class CommentsController < ApplicationController

  before_action :load_commentable

  def create
    @comment = @commentable.comments.create(comments_params.merge(user: current_user))
    @comment.user.increment!(:repa, 3)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if @comment.user == current_user
  end

  private

  def load_commentable
    parameter = (params[:commentable].singularize + '_id').to_sym
    @commentable = params[:commentable].classify.constantize.find(params[parameter])
  end

  def comments_params
    params.require(:comment).permit(:body, :user_id, :commentable_type, :commentable_id)
  end

end
