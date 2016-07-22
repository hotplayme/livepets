class SubscribersController < ApplicationController

  def create
    # находим юзера на кого подписываемся
    @user = User.find_by_nickname(params[:user_id])
    # создаем для этого юзера подписчика current_user
    @user.subscribers.create(user: current_user)
    # создаем уведомление для @user о новом подписчике
    current_user.notices.create(user: @user)
    # проверка и создание награды для @user
    @user.subscribers.reload
    if @user.subscribers.count >= 1000
      @user.rewards.create(badge: Badge.find_by_slug('subscribers-platinum')) unless @user.rewards.where(badge: Badge.find_by_slug('subscribers-platinum')).present?
    elsif @user.subscribers.count >= 100
      @user.rewards.create(badge: Badge.find_by_slug('subscribers-gold')) unless @user.rewards.where(badge: Badge.find_by_slug('subscribers-gold')).present?
    elsif @user.subscribers.count >= 10
          @user.rewards.create(badge: Badge.find_by_slug('subscribers-silver')) unless @user.rewards.where(badge: Badge.find_by_slug('subscribers-silver')).present?
    elsif @user.subscribers.count >= 1
      @user.rewards.create(badge: Badge.find_by_slug('subscribers-bronze')) unless @user.rewards.where(badge: Badge.find_by_slug('subscribers-bronze')).present?
    end
  end

  def destroy
    @user = User.find_by_nickname(params[:user_id])
    Subscriber.where(subscribable_type: 'User', subscribable_id: @user.id, user: current_user).delete_all
    current_user.notices.create(user: @user, add: false)
  end


end
