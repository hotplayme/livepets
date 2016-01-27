class Admin::CommentsController < AdminController

  def index
    @comments_new = Comment.where(approve: false).order('created_at DESC')
    @comments_old = Comment.where(approve: true).order('created_at DESC')
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comments_params)
    redirect_to admin_comments_path
  end

  def approve
    @comment = Comment.find(params[:admin_comment_id])
    @comment.update(approve: true)
  end

  def destroy
    @comment = Comment.find(params[:id])
    #admin = User.where(admin: true).first
    #dialog = admin.dialogs.includes(:users).where(users: {id: @comment.user.id}).first_or_create
    #dialog.messages.create(user_id: admin.id, body: "Добрый день. Ваш комментарий '#{@comment.body.first(200)}' был удален.")
    @comment.user.increment!(:repa, -3)
    @comment.destroy
    redirect_to admin_comments_path
  end

  private

  def comments_params
    params.require(:comment).permit(:body)
  end

end
