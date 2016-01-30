class SubscribersController < ApplicationController

  def create
    @user = User.find_by_nickname(params[:user_id])
    @user.subscribers.create(user: current_user)
    current_user.notices.create(user: @user)
  end

  def destroy
    @user = User.find_by_nickname(params[:user_id])
    Subscriber.where(subscribable_type: 'User', subscribable_id: @user.id, user: current_user).delete_all
    current_user.notices.create(user: @user, add: false)
  end


end
