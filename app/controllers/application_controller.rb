class ApplicationController < ActionController::Base
  class AccessDenied < StandardError; end

  rescue_from AccessDenied, with: :page_401

  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def user_signed_in?
    !!current_user
  end
  helper_method :user_signed_in?

  def authentication_required!
    raise AccessDenied unless user_signed_in?
  end

  def page_401
    render 'public/401', status: 401
  end
end
