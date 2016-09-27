require 'rails_helper'
require 'que/testing'

describe "EmailReceiverJob" do
  after { EmailReceiverJob.jobs.clear }

  it "handles mail messages" do
    EmailReceiverJob.enqueue('abc')
  end
end