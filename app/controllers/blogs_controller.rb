class BlogsController < ApplicationController

  include Voted
  before_action :blog_load, only: [:destroy]

  def index
    @blogs = Blog.where("created_at < ?", Time.now).where(del: false).order('created_at DESC').page(params[:page]).per(10)
  end
  
  def new
    Blog.transaction do
      @blog = Blog.new
      @blog.blog_attachments.build
    end
  end
  
  def create
    if current_user.writer
      if current_user.blogs.count > 0
        if Time.now - current_user.blogs.last.created_at > 12.hours
          time = Time.now
        else
          time = current_user.blogs.last.created_at + Random.rand(600..800).minutes
        end
      else
        time = Time.now
      end
    else
      time = Time.now
    end

    @blog = current_user.blogs.build(blog_params.merge(created_at: time))
    if @blog.save
      if params[:attach_ids].present?
        BlogAttachment.where(id: params[:attach_ids]).update_all(blog_id: @blog.id, user_id: current_user.id)
      end
      increment = 20 + (@blog.blog_attachments.count*2)

      @blog.user.increment!(:repa, increment)
      current_user.subscribes.create(blog: @blog)
      redirect_to blog_path(@blog)
    else
      flash[:notice] = "Заполните все поля"
      render 'new'
    end
  end

  def image_create
    params[:blog][:blog_attachment].each do |file|
      @file = BlogAttachment.create(file: file, user_id: current_user.id)
    end
  end
  
  def show
    begin
      @blog = Blog.find(params[:id])
      @comments = @blog.comments
      @comment = Comment.new
      @blog.notices.update_all(new:false)
    rescue
      redirect_to root_path, status: 301
    end
  end

  def edit
    if @blog = Blog.find_by_id(params[:id])
      redirect_to root_path if current_user != @blog.user
    else
      redirect_to root_path
    end
  end

  def update
    @blog = Blog.find(params[:id])
    if current_user == @blog.user
      if params[:attach_ids].present?
        BlogAttachment.where(id: params[:attach_ids]).update_all(blog_id: @blog.id, user_id: current_user.id)
      end
      if @blog.update(blog_params.merge(approve: false))
        redirect_to blog_path(@blog)
      end
    else
      redirect_to root_path
    end
  end
  
  def destroy
    if current_user == @blog.user
      increment = 20 + (@blog.blog_attachments.count*2)
      @blog.user.increment!(:repa, -increment)
      @blog.update(del:true)
      redirect_to user_path(@blog.user.nickname.downcase)
    else
      redirect_to root_path
    end
  end

  def a_delete
    @attachment = BlogAttachment.find(params[:id])
    @attachment.destroy if @attachment.user_id == current_user.id
  end

  
  private

  def blog_params
    params.require(:blog).permit(:title, :body, :approve, attachments_attributes:[:file])
  end

  def blog_load
    @blog = Blog.find(params[:id])
  end

end
