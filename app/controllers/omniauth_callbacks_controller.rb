class OmniauthCallbacksController < Devise::OmniauthCallbacksController


  def facebook
    @user = User.find_for_oauth_facebook(request.env['omniauth.auth'])
    user_sign_in
  end

  def vkontakte
    @user = User.find_for_oauth_vk(request.env['omniauth.auth'])
    user_sign_in
  end

  def yandex
    @user = User.find_for_oauth_yandex(request.env['omniauth.auth'])
    user_sign_in
  end

  def mailru
    @user = User.find_for_oauth_mailru(request.env['omniauth.auth'])
    user_sign_in
  end

  def google_oauth2
    @user = User.find_for_oauth_gmail(request.env['omniauth.auth'])
    user_sign_in
  end

  def odnoklassniki
    @user = User.find_for_oauth_ok(request.env['omniauth.auth'])
    user_sign_in
  end

  private

  def user_sign_in
    if @user.persisted?
      @user.remember_me = true
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: @user.authorizations.first.provider) if is_navigational_format?
    end
  end


end