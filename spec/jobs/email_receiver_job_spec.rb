require 'rails_helper'
require 'que/testing'

describe "EmailReceiverJob" do
  after { EmailReceiverJob.jobs.clear }

  let(:test_mail_two_pictures) { File.read(Rails.root.join("spec", "fixtures", "test_mail_two_pictures.eml")) }

  it "handles mail messages with 2 pictures" do
    EmailReceiverJob.enqueue(test_mail_two_pictures)
  end
end