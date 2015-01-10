class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(session_params[:username], session_params[:password])

    if @user
      log_in!(@user)
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    log_out!
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
