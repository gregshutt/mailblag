class InlineImg < ReverseMarkdown::Converters::Img
  def initialize(content_list)
    @content_list = content_list
  end

  def convert(node, state = {})
    if (! node['src'].nil?) && (node['src'].start_with? 'cid:')
      cid = node['src']
      cid.slice!('cid:')
      
      # find the associated image
      image = @content_list.find do |c|
        if c.has_key? :content_id
          c[:content_id] == cid
        else
          false
        end
      end

      if ! image.nil?
        post_image = image[:post_image]
        return " [![Image](#{post_image.image.url(:fullsize)})](#{post_image.image.url})\n\n"
      end

    else
      super
    end
  end
end

class EmailReceiverJob < Que::Job
  def run(message)
    # TODO fix this
    ActsAsTenant::current_tenant = Site.first

    mail = Mail::Message.new(message)

    # break the message apart
    if mail.multipart?
      content_list = handle_multipart_message(mail)
    else
      content_list = handle_message(mail)
    end

    post = Post.new(post_date: mail.date, title: mail.subject)

    # need to handle inline image attachments
    ReverseMarkdown::Converters.register :img, InlineImg.new(content_list)

    # compose the post
    content = StringIO.new
    content_list.each do |c|
      if c[:mime_type] == 'text/html'
        # convert html to markdown
        text_content = ReverseMarkdown.convert c[:content], unknown_tags: :bypass, tag_border: ''

        # convert the html entities
        text_content = HTMLEntities.new.decode text_content
      
      elsif c[:mime_type].start_with? 'image/'
        post_image = c[:post_image]
        text_content = "[![Image](#{post_image.image.url(:fullsize)})](#{post_image.image.url})\n\n"

        post.post_images << post_image
      
      else
        
        text_content = c[:content]
      end

      content << text_content
    end

    post.content = content.string

    post.save!
  end

  private
    def handle_message(mail)
      content_list = []

      # handle the text portion
      content_block = {mime_type: 'text/plain', content: mail.decoded}
      content_list << content_block

      content_list
    end

    def handle_multipart_message(mail, content_list = nil, content_map = nil)
      content_list ||= []
      content_map ||= {}

      # go through each part of the message
      mail.parts.each do |part|
        # parse the mime type
        mime_type = Mime::Type.parse(part.content_type)

        if mime_type.count != 1
          raise 'Unexpected mime type count'
        end

        mime_type = mime_type.first.to_str

        if mime_type.start_with? 'image/'
          # store the image
          temp_file = Tempfile.new(['email-attachment', 
            Rack::Mime::MIME_TYPES.invert[mime_type]])
          temp_file.binmode
          temp_file.write part.body.decoded
          temp_file.flush
          temp_file.rewind

          post_image = PostImage.create!(image: temp_file)
          
          # remove leading and trailing < >
          content_id = part.content_id
          if ! content_id.nil?
            content_id = content_id.gsub(/[<>]/, '')
          end

          new_content_block = {mime_type: mime_type, content_id: content_id,
            post_image: post_image}

          content_list << new_content_block

        elsif mime_type.start_with? 'text/'
          content = part.decoded

          case mime_type
          when 'text/html'

            # strip all the html
            raw_content = ActionController::Base.helpers.strip_tags(content)

            # replace all non breaking spaces with spaces
            raw_content.gsub!("\u00A0", ' ')

          when 'text/plain'

            # nothing special
            raw_content = content

          else
            # unknown text type
          end
          
          # remove newlines and spaces
          raw_content = raw_content.gsub(/\s+/, '')
          new_content_block = {content: content, mime_type: mime_type}

          content_list << new_content_block

          # check to see if this block already exists in html format
          if content_map.has_key? raw_content
            existing_block = content_map[raw_content]
            
            if existing_block[:mime_type] == 'text/plain'
              # replace the identical text block with the html block
              content_map[raw_content] = new_content_block
              content_list.delete existing_block
            end
          end
          
          content_map[raw_content] = new_content_block
        else
          # check for multipart part
          if part.multipart?
            handle_multipart_message(part, content_list, content_map)
          end
        end
      end

      content_list
    end
end