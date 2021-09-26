class ApplicationController < ActionController::Base
# default url
  #before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  before_action :layouts_value
  
  def layouts_value
    @user=current_user
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:accepted])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
    #devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :accepted, :nickname)}
  end
end
