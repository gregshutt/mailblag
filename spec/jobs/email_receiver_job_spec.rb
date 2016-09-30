require 'rails_helper'
require 'que/testing'

describe "EmailReceiverJob" do
  after { EmailReceiverJob.jobs.clear }

  let(:test_mail_two_pictures) { File.read(Rails.root.join("spec", "fixtures", "test_mail_two_pictures.eml")) }
  let(:test_mail_with_html) { File.read(Rails.root.join("spec", "fixtures", "test_mail_with_html.eml")) }

  it "handles mail messages with html" do
    EmailReceiverJob.enqueue(test_mail_with_html)

    # find the new post
    post = Post.first

    expect(post).not_to be_nil

    # get the title from the subject
    expect(post.title).to eq('Test')

    # get the post date from the mail date
    expect(post.post_date.utc.to_i).to(
      eq(DateTime.parse('Wed, 28 Sep 2016 10:57:39 -0400').to_i) )

    expect(post.content).to eq("Test text with bolded\u00A0**HTML**  \n  \nSent from my iPhone\n")
  end

  it "handles mail messages with 2 pictures" do
    EmailReceiverJob.enqueue(test_mail_two_pictures)

    # find the new post
    post = Post.first

    expect(post).not_to be_nil
    expect(post.title).to eq('Test mail')
    expect(post.post_date.utc.to_i).to(
      eq(DateTime.parse('Tue, 27 Sep 2016 12:37:24 -0400').to_i) )
  end
end