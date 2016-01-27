class PostsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.new(post_params)
    @post.user = current_user
    @post.save
    @topic.updated_at = Time.now
    @topic.save
    redirect_to topic_path(@topic)
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
