class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in!(@user)
      redirect_to root_path
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def index

  end

  def show
    @comments = current_user.comments
    render :show
  end

  private
    def user_params
      params.require(:user).permit(:username, :password)
    end
end
