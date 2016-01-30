class CommentsController < ApplicationController

  before_action :load_commentable, only: [:create]

  def create
    # создаем коммент для комментируемого объекта
    @comment = @commentable.comments.create(comments_params.merge(user: current_user))
    @comment.user.increment!(:repa, 3)
    # создаем подписчика на данный блог для current_user, если ее нет
    unless @commentable.subscribers.where(user: current_user).present?
      @commentable.subscribers.create(user: current_user)
    end
    # рассылаем подписчикам уведомление, кроме текущего юзера
    @commentable.subscribers.where.not(user: current_user).each do |subscriber|
      @commentable.notices.create(user:subscriber.user, cid: @comment.id) unless Notice.where(noticeable: @commentable, user: subscriber.user, new: true).present?
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
