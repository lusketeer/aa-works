class CommentsController < ApplicationController
  def index
    @comments = Comment.where(commentable_type: "Post")
    render :index
  end

  def new
    @comment = Comment.new
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
  end

  def show
  end

  def destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end

end
