class UsersController < ApplicationController

  def show
    if @user = User.find_by_nickname(params[:id])
      @pets = @user.mypets
      @blogs = @user.blogs.where("created_at < ?", Time.now).where(del: false).order('created_at DESC')
    else
      redirect_to root_path, status: 301
    end
  end

  def edit
    if current_user
      @user = current_user
      if @user.country.nil?
        @countries = Country.all
        @cities = City.where("country_id = ?", 1)
      else
        @countries = Country.all
        @cities = @user.country.cities
      end
    else
      redirect_to root_path
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user.nickname.downcase)
    else
      render 'edit'
    end
  end

  def update_avatar
    @user = current_user
    @user.update(avatar: params[:avatar])
  end

  def update_cities
    @cities = City.where("country_id = ?", params[:country_id])
    respond_to do |format|
      format.js
      format.html
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :country_id, :city_id, :avatar)
  end

end
