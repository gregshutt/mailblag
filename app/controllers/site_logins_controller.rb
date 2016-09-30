class SiteLoginsController < ApplicationController
  skip_before_filter :check_for_site_password
  
  def new
  end

  def create
    # check the password
    if params[:site_password] == 'turtle'
    else
      flash[:danger] = "Your password is incorrect."
      render 'new'
    end
  end
end