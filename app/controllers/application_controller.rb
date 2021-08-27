class ApplicationController < ActionController::Base
# default url
  #before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :layouts_value
  def layouts_value
    @user=current_user
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    devise_parameter_sanitizer.permit(:account_update, keys: %i(image))
  end
end
