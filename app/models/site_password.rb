# == Schema Information
#
# Table name: site_passwords
#
#  created_at :datetime
#  id         :integer          not null, primary key
#  password   :string
#  site_id    :integer
#  updated_at :datetime
#

class SitePassword < ActiveRecord::Base
  acts_as_tenant :site
end
