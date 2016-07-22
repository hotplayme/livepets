class Admin::BadgesController < AdminController

  def index
    @badges = Badge.all
  end

  def new
    @badge = Badge.new
  end

  def create
    @badge = Badge.create(badge_params)
    redirect_to admin_badges_path
  end

  def edit
    @badge = Badge.find(params[:id])
  end

  def update
    @badge = Badge.find(params[:id])
    @badge.update(badge_params)
    redirect_to admin_badges_path
  end

  def destroy
    @badge = Badge.find(params[:id])
    @badge.destroy!
    redirect_to admin_badges_path
  end

  private

  def badge_params
    params.require(:badge).permit(:name, :slug, :desc, :metal)
  end

end
