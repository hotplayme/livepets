class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authenticate_user!, except: [:index, :show, :index_dogs, :index_cats, :weekly]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_current_user

  def after_sign_in_path_for(resource)
    edit_user_path
  end

  def set_current_user
    User.current_user = current_user
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end
