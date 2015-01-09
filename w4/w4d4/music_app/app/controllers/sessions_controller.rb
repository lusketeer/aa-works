class SessionsController < ApplicationController
  before_action :redirect_after_login, except: :destroy
  def new
    render :new
  end

  def create
    u = User.find_by_credentials(session_params[:email],
                                session_params[:password])
    if u.nil?
      flash.now[:errors] = "Invalid Email/Password"
      render :new
    else
      log_in!(u)
      redirect_to root_path
    end
  end

  def destroy
    log_out!
    redirect_to root_path
  end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
