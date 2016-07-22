class Admin::MassSpamController < AdminController

  def index

  end

  def create
    if params[:users][:category] == 'all'
      # шлем всем
      User.where.not(id: current_user.id).each { |user| user.send_message(params[:message]) }
    elsif params[:users][:category] == 'writer'
      #шлем писателям
      User.where.not(id: current_user.id).where(writer: true).each { |user| user.send_message(params[:message]) }
    elsif params[:users][:category] == 'user'
      #шлем конкретным юзерам
      User.where(id:params[:user_ids]).each do |user|
        if current_user.dialogs.includes(:users).where(users: {id: user.id}).exists?
          dialog = current_user.dialogs.includes(:users).where(users: {id: user.id}).first
          dialog.messages.create(body: params[:message], user: current_user)
        else
          dialog = current_user.dialogs.create
          user.dialogs << dialog
          dialog.messages.create(body: params[:message], user: current_user)
        end
      end
    end
    redirect_to admin_mass_spam_index_path

  end

end
