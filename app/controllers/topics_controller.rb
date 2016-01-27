class TopicsController < ApplicationController

  def index
    @topics = Topic.order("updated_at DESC").page(params[:page]).per(20)
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      redirect_to topic_path(@topic)
    else
      render :new
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @topic.record_timestamps=false
    @topic.increment!(:views)
    @posts = @topic.posts.reverse
    @post  = Post.new
  end

  def edit
    @topic = Topic.find(params[:id])
    unless @topic.user == current_user
      redirect_to topic_path(@topic)
    end
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.update(topic_params)
    redirect_to topic_path(@topic)
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy!
    redirect_to topics_path
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :body, :user_id)
  end
end
