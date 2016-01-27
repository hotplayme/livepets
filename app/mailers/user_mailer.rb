class UserMailer < ApplicationMailer
  require 'digest/sha2'
  default "Message-ID"=>"<#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@livepets.ru>"
  default from: "info@livepets.ru"

  def send_new_user_message(user)
    @user = user
    mail(:to => user.email, :subject => "Добро пожаловать в livepets.ru")
  end

end
