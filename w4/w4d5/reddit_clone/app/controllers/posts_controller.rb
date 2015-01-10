class PostsController < ApplicationController
  def new
    @post = Post.new
    @all_subs = Sub.all
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      # @post.sub_ids = post_params[:sub_ids]
      redirect_to @post, notice: "Post Successfully Created"
    else
      flash.now[:error] = @post.errors.full_messages
      redirect_to @post.sub
    end
  end

  def show
    @post = Post.find(params[:id])
    @subs = @post.subs
    render :show
  end

  def edit
    @post = Post.find(params[:id])
    @all_subs = Sub.all

    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: "Update Succeeded"
    else
      flash.now[:error] = @post.errors.full_messages
      render :edit
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :content, :url, sub_ids: [])
    end
end
