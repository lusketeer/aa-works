class SessionsController < ApplicationController
  before_action :logged_in?, only: [:new, :create]
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:session][:user_name], params[:session][:password])

    if user.nil?
      flash.now[:errors] = "Invalid Login Combination"
      render :new
    else
      login_user!(user)
      redirect_to root_path
    end
  end

  def destroy
    log_out!
    redirect_to root_path
  end
end
