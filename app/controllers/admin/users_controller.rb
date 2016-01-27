class Admin::UsersController < AdminController

  before_action :find_user, except: [:index]

  def index
    if params[:sort] == 'bots'
      @users = User.where(bot: true).order("created_at DESC").page(params[:page]).per(30)
    elsif params[:sort] == 'new'
      @users = User.where(approve: false).order("created_at DESC").page(params[:page]).per(30)
    elsif params[:sort] == 'banned'
      @users = User.where(block: true).order("created_at DESC").page(params[:page]).per(30)
    elsif params[:sort] == 'writer'
      @users = User.where(writer: true).order("created_at DESC").page(params[:page]).per(30)
    else
      @users = User.where(bot: false).order("created_at DESC").page(params[:page]).per(30)
    end
  end

  def show
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_users_path
  end

  def approve
    @user.update(approve: true)
  end

  def block
    @user.update(block:true)
  end

  def unblock
    @user.update(block:false)
  end

  def delete
    @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :admin, :writer)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
