# == Schema Information
#
# Table name: sites
#
#  created_at       :datetime
#  hostname         :string
#  id               :integer          not null, primary key
#  is_default       :boolean
#  require_password :boolean
#  title            :string
#  updated_at       :datetime
#

class Site < ActiveRecord::Base
end
