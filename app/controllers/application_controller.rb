class ApplicationController < ActionController::Base
  before_action :basic_auth
  protect_from_forgery with: :exception


  include SessionsHelper
  
  private
  
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
