require 'rails_helper'
require 'que/testing'

describe "EmailReceiverJob" do
  after { EmailReceiverJob.jobs.clear }

  let(:test_mail_two_pictures) { File.read(Rails.root.join("spec", "fixtures", "test_mail_two_pictures.eml")) }
  let(:test_mail_with_html) { File.read(Rails.root.join("spec", "fixtures", "test_mail_with_html.eml")) }

  it "handles mail messages with 2 pictures" do
    EmailReceiverJob.enqueue(test_mail_two_pictures)
  end

  it "handles mail messages with html" do
    EmailReceiverJob.enqueue(test_mail_with_html)
  end
end