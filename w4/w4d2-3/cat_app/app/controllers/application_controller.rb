class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    user_token = UserToken.find_by(session_token: session[:session_token])
    if user_token.nil?
      return nil
    else
      user_token.user
    end
  end

  def login_user!(user)
    token = user.create_session_token
    user.session_tokens.create(session_token: token,
                              device_info: request.env["HTTP_USER_AGENT"],
                              ip_address: request.remote_ip)
    session[:session_token] = token
  end

  def logged_in?
    redirect_to cats_url unless current_user.nil?
  end

  def log_out!
    UserToken.find_by(session_token: session[:session_token]).destroy
    session[:session_token] = nil
  end
end
