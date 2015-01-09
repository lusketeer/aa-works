class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_in!(user)
    if user.activated?
      user.reset_session_token
      session[:session_token] = user.session_token
    else
      redirect_to new_session_path, errors: "Account is not activated"
    end
  end

  def log_out!
    current_user.reset_session_token
    session[:session_token] = nil
  end

  def require_login
    redirect_to new_session_path unless logged_in?
  end

  def redirect_after_login
    redirect_to root_path if logged_in?
  end
end
