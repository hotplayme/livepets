class AdminController < ApplicationController

  before_action :check_admin

  def index
  end


  def pet
    if params[:sort] == 'real'
      @pets = Mypet.joins(:user).where("users.bot = false").order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
    elsif params[:sort] == 'bots'
      @pets = Mypet.joins(:user).where("users.bot = true").order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
    elsif params[:sort] == 'new'
      @pets = Mypet.where(approve: false).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
    elsif params[:sort] == 'banned'
      @pets = Mypet.where(block: true).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
    else
      @pets = Mypet.order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
    end
  end

  def comment
    @comments = Comment.all.reverse
  end

  def forums
    @topics = Topic.all.reverse
  end
  
  private
  def city_params
    params.require(:city).permit(:name, :country_id)
  end
  
  def article_params
    params.require(:article).permit(:title, :body, :randid, :avatar, :created_at)
  end
  
  def breed_params
    params.require(:breed).permit(:name, :breed_type, :translate, :avatar)
  end

  def post_params
    params.require(:blog).permit(:title, :body)
  end

  def check_admin
    unless current_user && current_user.admin || current_user.moderator
      redirect_to root_path
    else
      unless params[:controller] == 'admin/articles' || params[:controller] == 'admin/tags' || current_user.admin
        redirect_to admin_articles_path
      end
    end

  end

  def check_moderator

  end
end
