require 'api/coolpay/authentication'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def authenticate
    redirect_to :login unless user_logged_in?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_logged_in?
    current_user.present?
  end

  def validate_author(object)
    redirect_back(fallback_location: root_path) unless current_user == object.user
  end

  def token
    credentials = current_user.credentials.first
    token = Api::Coolpay::Authentication.login(credentials.username, credentials.apikey)['token']
    redirect_back(fallback_location: root_path) if token.empty?

    token
  end
end
