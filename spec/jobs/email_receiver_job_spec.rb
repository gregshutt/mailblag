require 'rails_helper'
require 'que/testing'

describe "EmailReceiverJob" do
  before { Site.create() }
  after { EmailReceiverJob.jobs.clear }

  let(:test_mail_plaintext) { File.read(Rails.root.join("spec", "fixtures", "test_mail_plaintext.eml")) }
  let(:test_mail_plaintext_with_attachments) { File.read(Rails.root.join("spec", "fixtures", "test_mail_plaintext_with_attachments.eml")) }
  let(:test_mail_with_html) { File.read(Rails.root.join("spec", "fixtures", "test_mail_with_html.eml")) }
  let(:test_mail_one_picture) { File.read(Rails.root.join("spec", "fixtures", "test_mail_one_picture.eml")) }
  let(:test_mail_two_pictures) { File.read(Rails.root.join("spec", "fixtures", "test_mail_two_pictures.eml")) }

  it "handles mail messages with plaintext" do
    EmailReceiverJob.enqueue(test_mail_plaintext)

    # find the new post
    post = Post.first

    expect(post).not_to be_nil

    # get the title from the subject
    expect(post.title).to eq('Plain text email')

    # get the post date from the mail date
    expect(post.post_date.utc.to_i).to(
      eq(DateTime.parse('Fri, 30 Sep 2016 14:32:56 -0400').to_i) )

    expect(post.content).to eq("Test plain text\n")
  end

  it "handles mail messages with plaintext and attachments" do
    EmailReceiverJob.enqueue(test_mail_plaintext_with_attachments)

    # find the new post
    post = Post.first

    expect(post).not_to be_nil

    # get the title from the subject
    expect(post.title).to eq('Plain text with attachments')

    # get the post date from the mail date
    expect(post.post_date.utc.to_i).to(
      eq(DateTime.parse('Fri, 30 Sep 2016 14:40:34 -0400').to_i) )

    expect(post.post_images.length).to eq 1
    expect(post.post_images[0]).not_to be_nil

    expect(post.content).to eq("Attachments included\n\n[![Image]()]()\n\n")
  end

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

  it "handles mail messages with 1 picture" do
    EmailReceiverJob.enqueue(test_mail_one_picture)

    # find the new post
    post = Post.first

    expect(post).not_to be_nil
    expect(post.title).to eq('Test post')
    expect(post.post_date.utc.to_i).to(
      eq(DateTime.parse('Sun, 2 Oct 2016 21:45:19 -0400').to_i) )

    expect(post.post_images.length).to eq 1
    expect(post.post_images[0]).not_to be_nil

    expect(post.content).to eq("[![Image]()]()\n\n\n\nSent from my iPhone")
  end

  it "handles mail messages with 2 pictures" do
    EmailReceiverJob.enqueue(test_mail_two_pictures)

    # find the new post
    post = Post.first

    expect(post).not_to be_nil
    expect(post.title).to eq('Test mail')
    expect(post.post_date.utc.to_i).to(
      eq(DateTime.parse('Tue, 27 Sep 2016 12:37:24 -0400').to_i) )

    expect(post.post_images.length).to eq 2
    expect(post.post_images[0]).not_to be_nil
    expect(post.post_images[1]).not_to be_nil

    expect(post.content).to eq("[![Image]()]()\n\n[![Image]()]()\n\n\n\nTest text\n\nSent from my iPhone")
  end
end