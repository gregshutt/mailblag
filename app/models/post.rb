# == Schema Information
#
# Table name: posts
#
#  content    :text
#  created_at :datetime
#  id         :integer          not null, primary key
#  post_date  :datetime
#  title      :string
#  updated_at :datetime
#  url        :string
#

class Post < ActiveRecord::Base
end
