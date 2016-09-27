class EmailReceiverJob < Que::Job
  def run(message)
    mail = Mail::Message.new(message)
  end
end