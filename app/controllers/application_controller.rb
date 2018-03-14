class ApplicationController < ActionController::Base
  protect_from_forgery(with: :exception)

  def current_user
    @current_user ||= session[:current_user_id] ? User.find(session[:current_user_id]) : nil
  end
end
