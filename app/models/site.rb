# == Schema Information
#
# Table name: sites
#
#  created_at       :datetime
#  id               :integer          not null, primary key
#  require_password :boolean
#  title            :string
#  updated_at       :datetime
#

class Site < ActiveRecord::Base
end
