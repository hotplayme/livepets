class BlogsController < ApplicationController

  include Voted

  def index
    @blogs = Blog.where("created_at < ?", Time.now).where(del: false).order('created_at DESC').page(params[:page]).per(10)
  end

  def my
    ids = Subscriber.where(subscribable_type: 'User', user_id: current_user.id).pluck(:subscribable_id)
    @blogs = Blog.where("blogs.created_at < ?", Time.now).where(del: false).joins(:user).where(users: {id: ids}).order('created_at DESC').page(params[:page]).per(10)
    current_user.update(my_feed_count: 0)
    render 'blogs/index'
  end
  
  def new
    Blog.transaction do
      @blog = Blog.new
      @blog.blog_attachments.build
    end
  end
  
  def create
    #Установка created_at для писателей
    if current_user.writer
      if current_user.blogs.count > 0
        if Time.now - current_user.blogs.order("created_at desc").first.created_at > 3.days
          time = Time.now
        else
          time = current_user.blogs.order("created_at desc").first.created_at + Random.rand(48..120).hours
        end
      else
        time = Time.now
      end
    else
      time = Time.now
    end

    @blog = current_user.blogs.build(blog_params.merge(created_at: time))
    if @blog.save
      # создание картинок, если они есть
      if params[:attach_ids].present?
        BlogAttachment.where(id: params[:attach_ids]).update_all(blog_id: @blog.id, user_id: current_user.id)
        @blog.update(blog_attachments_count: @blog.blog_attachments.count)
      end
      increment = 20 + (@blog.blog_attachments.count*2)
      @blog.user.increment!(:repa, increment)

      # Создание подписки на этот блог для автора
      @blog.subscribers.create(user: current_user)

      # Увеличение my_feed_count для подписчиков
      current_user.subscribers.joins(:user).update_all("users.my_feed_count = users.my_feed_count + 1")

      # проверка для создания награды для юзера
      current_user.blogs.reload
      if current_user.blogs.count >= 500
        current_user.rewards.create(badge: Badge.find_by_slug('blogger-platinum')) unless current_user.rewards.where(badge: Badge.find_by_slug('blogger-platinum')).present?
      elsif current_user.blogs.count >= 100
        current_user.rewards.create(badge: Badge.find_by_slug('blogger-gold')) unless current_user.rewards.where(badge: Badge.find_by_slug('blogger-gold')).present?
      elsif current_user.blogs.count >= 10
        current_user.rewards.create(badge: Badge.find_by_slug('blogger-silver')) unless current_user.rewards.where(badge: Badge.find_by_slug('blogger-silver')).present?
      elsif current_user.blogs.count >= 1
        current_user.rewards.create(badge: Badge.find_by_slug('blogger-bronze')) unless current_user.rewards.where(badge: Badge.find_by_slug('blogger-bronze')).present?
      end

      redirect_to blog_path(@blog)
    else
      flash[:notice] = "Заполните все поля"
      render :new
    end
  end

  def image_create
    params[:blog][:blog_attachment].each do |file|
      @file = BlogAttachment.create(file: file, user_id: current_user.id)
    end
  end
  
  def show
    if @blog = Blog.find_by_id(params[:id])
      if browser.known?
        @blog.notices.where(user: current_user).delete_all if current_user
        # инкремент views для блога
        #@blog.increment!(:views, 1)
        # создание награды для автора @blog за views
        if @blog.views >= 10000
          @blog.user.rewards.create(badge: Badge.find_by_slug('blog-views-platinum')) unless @blog.user.rewards.where(badge: Badge.find_by_slug('blog-views-platinum')).present?
        elsif @blog.views >= 2500
          @blog.user.rewards.create(badge: Badge.find_by_slug('blog-views-gold')) unless @blog.user.rewards.where(badge: Badge.find_by_slug('blog-views-gold')).present?
        elsif @blog.views >= 1000
          @blog.user.rewards.create(badge: Badge.find_by_slug('blog-views-silver')) unless @blog.user.rewards.where(badge: Badge.find_by_slug('blog-views-silver')).present?
        elsif @blog.views >= 100
          @blog.user.rewards.create(badge: Badge.find_by_slug('blog-views-bronze')) unless @blog.user.rewards.where(badge: Badge.find_by_slug('blog-views-bronze')).present?
        end

        # создание награды для автора @blog за лайки блога
        if @blog.votes.count >= 200
          @blog.user.rewards.create(badge: Badge.find_by_slug('blog-votes-platinum')) unless @blog.user.rewards.where(badge: Badge.find_by_slug('blog-votes-platinum')).present?
        elsif @blog.votes.count >= 100
          @blog.user.rewards.create(badge: Badge.find_by_slug('blog-votes-gold')) unless @blog.user.rewards.where(badge: Badge.find_by_slug('blog-votes-gold')).present?
        elsif @blog.votes.count >= 50
          @blog.user.rewards.create(badge: Badge.find_by_slug('blog-votes-silver')) unless @blog.user.rewards.where(badge: Badge.find_by_slug('blog-votes-silver')).present?
        elsif @blog.votes.count >= 10
          @blog.user.rewards.create(badge: Badge.find_by_slug('blog-votes-bronze')) unless @blog.user.rewards.where(badge: Badge.find_by_slug('blog-votes-bronze')).present?
        end
      end
    else
      redirect_to root_path, status: 301
    end
  end

  def edit
    if @blog = Blog.find_by_id(params[:id])
      redirect_to root_path if current_user != @blog.user || @blog.payed
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
      else
        render :edit
      end
    else
      redirect_to root_path
    end
  end
  
  def destroy
    @blog = Blog.find(params[:id])
    if current_user == @blog.user
      increment = 20 + (@blog.blog_attachments.count*2)
      @blog.user.increment!(:repa, -increment)
      @blog.update(del:true)
      redirect_to user_path(current_user.nickname.downcase)
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


end
