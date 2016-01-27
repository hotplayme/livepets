class DialogsController < ApplicationController

  before_action :authenticate_user!
  
  def index
    if current_user
      @dialogs = current_user.dialogs.includes(:messages).order("messages.created_at desc")
    else
      redirect_to root_path
    end
  end
  
  def show
    @user = User.find_by_nickname(params[:nickname])
    @dialogs = current_user.dialogs.includes(:messages).order("messages.created_at desc")

    if @user.nil? || current_user == @user
      redirect_to dialogs_path
    elsif current_user.dialogs.includes(:users).where(users: {id: @user.id}).exists?
      @dialog = current_user.dialogs.includes(:users).where(users: {id: @user.id}).first
      @message = Message.new
      if @dialog.messages.where(user: @user).count > 0
        @dialog.messages.where(user: @user).update_all(state: 'old')
      end
    else
      @dialog = current_user.dialogs.create
      @user.dialogs << @dialog
      @message = current_user.messages.new
    end
    
  end
  
  def send_message
    @user = User.find_by_nickname(params[:nickname])
    @dialog = Dialog.find(params[:message][:dialog_id])
    @dialog.messages.create(message_params.merge(user: current_user))
    redirect_to dialogs_show_path
  end
  
  private
  
  def message_params
    params.require(:message).permit(:body, :dialog_id, :user_id)
  end
  
end
