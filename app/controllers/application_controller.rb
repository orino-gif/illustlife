class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :layouts_value
  
  def layouts_value
    @login_user=current_user
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:accepted])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
  end
end
