class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  set_current_tenant_through_filter
  before_filter :find_site

  private
    def find_site
      @site = Site.where(hostname: request.host.downcase).first || Site.first
      ActsAsTenant::current_tenant = @site
    end
end
