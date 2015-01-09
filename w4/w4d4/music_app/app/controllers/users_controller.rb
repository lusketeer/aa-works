class UsersController < ApplicationController
  before_action :redirect_after_login, except: :activate
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      flash[:notice] = "User Successfully Created, Please check your email to activate"
      redirect_to root_path
      msg = UserMailer.activation_email(@user)
      msg.deliver
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def activate
    activation_token = params[:activation_token]
    email = params[:email]
    u = User.find_by(activation_token: activation_token, email: email)

    if u.nil?
      redirect_to root_path, errors: "Invalid Token/Email Combinaiton"
    else
      u.activate!
      log_in!(u)
      redirect_to root_path
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
