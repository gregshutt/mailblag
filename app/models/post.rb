# == Schema Information
#
# Table name: posts
#
#  content    :text
#  created_at :datetime
#  id         :integer          not null, primary key
#  post_date  :datetime
#  site_id    :integer
#  title      :string
#  updated_at :datetime
#  url        :string
#

class Post < ActiveRecord::Base
  acts_as_tenant :site
  
  has_many :post_images
end
