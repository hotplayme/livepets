class NoticesController < ApplicationController

  before_action :authenticate_user!

  def index
  end

  # подписчики юзера
  def followers
    @followers = current_user.subscribers
  end

  # подписки юзера
  def following
    @following = current_user.my_subscribers.where(subscribable_type:'User')
  end

  def destroy
    @notice = Notice.find(params[:id])
    @notice.destroy
  end

  def newpets
    # находим ID пород, на которые мы подписаны
    @ids = current_user.my_subscribers.where(subscribable_type: 'Breed').pluck(:subscribable_id)
    @dogs = Breed.where(breed_type: 'Dog').where.not(id: @ids)
    @cats = Breed.where(breed_type: 'Cat').where.not(id: @ids)
  end

  def breed_subscribers_create
    breeds = Breed.where(id: params[:breed_id])
    breeds.each do |breed|
      breed.subscribers.create(user:current_user)
    end
    redirect_to newpets_notices_path
  end

  def breed_subscribers_delete
    breed = Breed.find(params[:breed_id])
    breed.subscribers.where(user: current_user).delete_all
    redirect_to newpets_notices_path
  end

end