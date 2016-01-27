class Admin::ForumsController < AdminController

  def index
    if params[:all] == 'true'
      @topics_not_approve = Topic.all.reverse
      @posts_not_approve = Post.all.reverse

    else
      @topics_not_approve = Topic.where(approve: false).reverse
      @posts_not_approve = Post.where(approve: false).reverse
    end
  end

  def topic_approve
    @topic = Topic.find(params[:admin_forum_id])
    @topic.update(approve:true)
    @topic.user.increment!(:repa, 7)
    @topic.user.increment!(:repa_total, 7)
    redirect_to admin_forums_path
  end

  def post_approve
    @post = Post.find(params[:id])
    @post.update(approve:true)
    @post.user.increment!(:repa, 4)
    @post.user.increment!(:repa_total, 4)
    redirect_to admin_forums_path
  end

  def topic_delete
    @topic = Topic.find(params[:admin_forum_id])
    @topic.destroy
    redirect_to admin_forums_path
  end

  def post_delete
    @post = Post.find(params[:admin_forum_id])
    @post.destroy
    redirect_to admin_forums_path
  end

end
