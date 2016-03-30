class TopicsController < ApplicationController

  def index
    @attach_topics = Topic.where(attach: true)
    @topics = Topic.where(attach: false).order("updated_at DESC").page(params[:page]).per(20)
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      @topic.subscribers.create(user: current_user)
      redirect_to topic_path(@topic)
    else
      render :new
    end
  end

  def show
    if @topic = Topic.find_by_id(params[:id])
      @topic.notices.where(user: current_user).delete_all if current_user
      @topic.record_timestamps=false
      @topic.increment!(:views)
      @posts = @topic.posts
      @post  = Post.new
    else
      redirect_to topics_path
    end
  end

  def edit
    if @topic = Topic.find_by_id(params[:id])
      redirect_to topics_path unless @topic.user == current_user
    else
      redirect_to topics_path
    end
  end

  def update
    if @topic = Topic.find_by_id(params[:id])
      if @topic.user == current_user
        @topic.update(topic_params)
        redirect_to topic_path(@topic)
      else
        redirect_to topics_path
      end
    else
      redirect_to topics_path
    end
  end

  def destroy
    if @topic = Topic.find_by_id(params[:id])
      @topic.destroy if @topic.user == current_user
    end
    redirect_to topics_path
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :body, :attach)
  end
end
