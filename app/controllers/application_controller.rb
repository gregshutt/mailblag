class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  set_current_tenant_through_filter
  before_filter :find_site, :check_for_site_password

  private
    def find_site
      @site = Site.where(hostname: request.host.downcase).first || Site.where(is_default: true).first!
      ActsAsTenant::current_tenant = @site
    end

    def check_for_site_password
      # should never get to this..
      raise "Site has not been created" if @site.nil?

      if @site.require_password
        if ! session[:site_password_id]
          # gotta login
          redirect_to site_login_path
        end
      end
    end
end
