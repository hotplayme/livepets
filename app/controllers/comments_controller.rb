class CommentsController < ApplicationController

  before_action :load_commentable, only: [:create]

  def create
    # создаем коммент для комментируемого объекта
    @comment = @commentable.comments.create(comments_params.merge(user: current_user))
    # увеличиваем репу для юзера
    @comment.user.increment!(:repa, 3)
    # проверка кол-ва комментов у юзера и выдача награды
    current_user.comments.reload
    if current_user.comments.count >= 15000
      current_user.rewards.create(badge: Badge.find_by_slug('comments-platinum')) unless current_user.rewards.where(badge: Badge.find_by_slug('comments-platinum')).present?
    elsif current_user.comments.count >= 1000
      current_user.rewards.create(badge: Badge.find_by_slug('comments-gold')) unless current_user.rewards.where(badge: Badge.find_by_slug('comments-gold')).present?
    elsif current_user.comments.count >= 50
      current_user.rewards.create(badge: Badge.find_by_slug('comments-silver')) unless current_user.rewards.where(badge: Badge.find_by_slug('comments-silver')).present?
    elsif current_user.comments.count >= 1
      current_user.rewards.create(badge: Badge.find_by_slug('comments-bronze')) unless current_user.rewards.where(badge: Badge.find_by_slug('comments-bronze')).present?
    end
    # проверка кол-ва комментов у блога и выдача награды для хозяина блога
    if @commentable.class.name == 'Blog'
      if @commentable.comments.count >= 200
        @commentable.user.rewards.create(badge: Badge.find_by_slug('blog-comments-platinum')) unless current_user.rewards.where(badge: Badge.find_by_slug('blog-comments-platinum')).present?
      elsif @commentable.comments.count >= 100
        @commentable.user.rewards.create(badge: Badge.find_by_slug('blog-comments-gold')) unless current_user.rewards.where(badge: Badge.find_by_slug('blog-comments-gold')).present?
      elsif @commentable.comments.count >= 50
        @commentable.user.rewards.create(badge: Badge.find_by_slug('blog-comments-silver')) unless current_user.rewards.where(badge: Badge.find_by_slug('blog-comments-silver')).present?
      elsif @commentable.comments.count >= 10
        @commentable.user.rewards.create(badge: Badge.find_by_slug('blog-comments-bronze')) unless current_user.rewards.where(badge: Badge.find_by_slug('blog-comments-bronze')).present?
      end
    end
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
