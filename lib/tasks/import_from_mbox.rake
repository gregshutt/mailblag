task :import_from_mbox, [:mbox_file] => [:environment] do |task, args|
  if args[:mbox_file].nil?
    puts "Usage: rake import_from_mbox['path/to/mbox']"
    exit
  end

  message = ''
  message_count = 0
  File.foreach(args[:mbox_file]) do |line|
    if line.match(/\AFrom /)
      next if message.blank?

      # parse the email
      mail = Mail::Message.new(message)

      

      # only use messages that are not in reference to any others
      #  that is, replies and forwards
      if (mail.header['In-Reply-To']) || (mail.header['References']) ||
        (mail.subject =~ /\ARe:/i) || (mail.subject =~ /\AFwd:/i)
        # reset
        message = ''
        
        next
      end

      message_count += 1

      # import
      EmailReceiverJob.enqueue(message)

      message = ''
    else
      message << line.sub(/^\>From/, 'From')
    end
  end

  puts "Imported #{message_count} messages"
end