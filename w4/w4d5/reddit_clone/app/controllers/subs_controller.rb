class SubsController < ApplicationController
  def index
    @subs = Sub.all
    render :index
  end

  def new
    @sub = current_user.moderated_subs.new
  end

  def create
    @sub = current_user.moderated_subs.new(sub_params)

    if @sub.save
      redirect_to @sub
    else
      flash.now[:error] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])

     if @sub.update(sub_params)
       redirect_to @sub
     else
       flash.now[:error] = @sub.errors.full_messages
       render :edit
     end
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    redirect_to subs_path
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts
    @post = Post.new
    render :show
  end

  private
    def sub_params
      params.require(:sub).permit(:title, :description)
    end
end
