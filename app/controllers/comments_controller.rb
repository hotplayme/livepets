class CommentsController < ApplicationController

  before_action :load_commentable, only: [:create]

  def create
    @comment = @commentable.comments.create(comments_params.merge(user: current_user))
    @comment.user.increment!(:repa, 3)
    # проверка, есть ли у текущего юзера уведомление о новой записи в этом объекте
    if @commentable.user.id.to_i != current_user.id.to_i
      @notice  = @commentable.notices.create(user:@commentable.user, cid: @comment.id) unless @commentable.user.notices.where(noticeable_type: @commentable.class.name, noticeable_id: @commentable.id, new: true).present?
    end
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
