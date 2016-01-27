class Admin::BlogsController < AdminController

  include ActionView::Helpers::SanitizeHelper

  def index
    if params[:sort] == 'new'
      @blogs = Blog.where(approve: false).where(del: false)
    elsif params[:sort] == 'del'
      @blogs = Blog.where(del: true)
    elsif params[:sort] == 'users'
      @users = User.where(writer:true)
    else
      @blogs = Blog.order("created_at DESC")
    end
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    @blog.update(blog_params)
    redirect_to admin_blogs_path
  end

  def destroy
    @blog = Blog.find(params[:id])
    #admin = User.where(admin: true).first
    #dialog = admin.dialogs.includes(:users).where(users: {id: @blog.user.id}).first_or_create
    #dialog.messages.create(user_id: admin.id, body: "Добрый день. Ваша запись '#{@blog.title}' была удалена за нарушение правил.")
    increment = 20 + (@blog.blog_attachments.count*2)
    @blog.user.increment!(:repa, -increment)
    @blog.destroy
    redirect_to admin_blogs_path
  end

  def approve
    @blog = Blog.find(params[:admin_blog_id])
    @blog.update(approve: true, comment: 'принят')
    redirect_to admin_blog_path(@blog)
  end

  def pay_blog
    blog = Blog.find(params[:admin_blog_id])
    blog.update(payed:true)
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :body, :approve)
  end

end
