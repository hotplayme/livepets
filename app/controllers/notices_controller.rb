class NoticesController < ApplicationController

  def index
    @notices = current_user.notices.order('created_at DESC')
    #@notices.where(new:true).update_all(new:false)
  end

  def destroy
    @notice = Notice.find(params[:id])
    @notice.destroy
  end

end
