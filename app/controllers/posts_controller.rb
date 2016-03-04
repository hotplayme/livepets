class PostsController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.new(post_params.merge(user: current_user))
    if @post.save
      # текущего юзера добавить в подписчики данного топика
      @topic.subscribers.create(user: current_user) unless @topic.subscribers.where(user: current_user).present?
      # разослать всем(кроме себя) уведомления о новой записи в топике
      @topic.subscribers.where.not(user: current_user).each do |s|
        @topic.notices.create(user: s.user) unless @topic.notices.where(user: s.user, new: true).present?
      end
      redirect_to topic_path(@topic)
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to topic_path(@topic)
    end
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to topic_path(@topic)
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    @post.destroy!
    redirect_to topic_path(@topic)
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
