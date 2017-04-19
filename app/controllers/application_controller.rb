class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :validate_user, :get_requester

  def login(user)
    session[:session_token] = user.session_token
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def validate_user
    !current_user.cats.where(id: params[:id]).empty?
  end

  def get_requester(id)
    User.find(id).username
  end

  def logout
    current_user.reset_session_token!
    session[:session_token] = nil
  end
end
