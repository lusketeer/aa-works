class UsersController < ApplicationController
  before_action :logged_in?#, except: [:new, :create]
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      login_user!(@user)
      redirect_to cats_url
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
