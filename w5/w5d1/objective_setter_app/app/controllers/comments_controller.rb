class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.commenter = current_user

    model_name = @comment.commentable_type
    model_id = @comment.commentable_id
    @object = model_name.capitalize.constantize.find(model_id)
    if @comment.save
      redirect_to @object
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to @object
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :commentable_type, :commentable_id)
    end
end
