# == Schema Information
#
# Table name: post_images
#
#  created_at :datetime
#  id         :integer          not null, primary key
#  image      :string
#  post_id    :integer
#  updated_at :datetime
#

class PostImage < ActiveRecord::Base
  mount_uploader :image, PostImageUploader

  belongs_to :post
end
