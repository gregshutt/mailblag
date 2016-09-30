class SiteLoginsController < ApplicationController
  skip_before_filter :check_for_site_password
  
  def new
  end

  def create
    # check the password
    site_password = SitePassword.find(password: params[:site_password]).first

    if ! site_password.nil?
      session[:site_password_id] = site_password.id
      redirect_to root_path
    else
      flash[:danger] = "Your password is incorrect."
      render 'new'
    end
  end
end