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

        mime_type = mime_type.first
        
        if mime_type.to_str.start_with? 'image/'
          puts part.attachment?
        elsif mime_type.to_str.start_with? 'text/'
          puts part.body
        else
          puts mime_type.inspect
        end
      end
    end
  end
end