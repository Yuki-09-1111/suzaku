class ApplicationController < ActionController::Base
  http_basic_authenticate_with :name => ENV['BASIC_USERNAME'], :password => ENV['BASIC_PASSWORD'] if Rails.env == "production"

  include SessionsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
