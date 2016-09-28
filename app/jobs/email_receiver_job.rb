class EmailReceiverJob < Que::Job
  def run(message)
    mail = Mail::Message.new(message)

    if mail.multipart?
      # go through each part of the message
      mail.parts.each do |part|
        # parse the mime type
        mime_type = Mime::Type.parse(part.content_type)

        if mime_type.count != 1
          raise 'Unexpected mime type count'
        end

        mime_type = mime_type.first.to_str
        
        if mime_type.start_with? 'image/'
          puts part.attachment?
        elsif mime_type.start_with? 'text/'

          if mime_type == 'text/html'
            # sanitize the html
            content = ActionView::Helpers::SanitizeHelper.strip_tags(part.body)
            puts "html: #{content}"
          elsif mime_type == 'text/plain'
            puts "plain: #{part.body}"
          end
            #puts part.body
        else
          puts mime_type.inspect
        end
      end
    end
  end
end