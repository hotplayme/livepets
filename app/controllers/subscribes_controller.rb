class SubscribesController < ApplicationController

  def subscribe
    @user = User.find(params[:id])
    if current_user.subscribes.where(subscriber_id: @user.id).exists?
      current_user.subscribes.where(subscriber_id: @user.id).delete_all
    else
      current_user.subscribes.create(subscriber_id: @user.id)
    end
  end

end
