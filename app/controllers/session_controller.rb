class SessionController < ApplicationController
  def create
    byebug
    user = User.find_or_create_from_auth_hash(auth_hash)
    session[:current_user_id] = user.id
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
