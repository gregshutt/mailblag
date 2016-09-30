class SiteLoginsController < ApplicationController
  skip_before_filter :check_for_site_password
  
  def new
  end
end