class HomeController < ApplicationController
  
  def index
    @articles = Article.where("created_at < ?", Time.now).order("created_at DESC").limit(6)
    @pet_day = Winner.last.user.pets.where("pet_attachments_count > 0").sample if Winner.count > 1
    @pets = Pet.where("pet_attachments_count > 0").includes(:pet_attachments).includes(:user).order("created_at DESC").limit(12)
    if current_user && current_user.city
      @pets_city = current_user.city.pets.where("pet_attachments_count > 0").includes(:pet_attachments).includes(:user).order("created_at DESC").limit(12)
    end
  end


  def refresh
    @pets = Pet.where("photo_file_name NOT IN (?)", "nil").order("Rand()").limit(12)
  end

  def weekly
    @top5 = User.order("repa DESC").limit(5)
    @winners = Winner.all
  end

  def index2
    render :layout => false
  end


  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :country, :sex, :nickname, :birthday, :avatar, :crop_x, :crop_y, :crop_w, :crop_h)
  end
  
  def breed_params
    params.require(:breed).permit(:name, :breed_type, :translate)
  end
  

  
end
