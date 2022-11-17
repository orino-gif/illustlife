class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  include WorksHelper

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nick,:agree,:uid,
    :provider])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nick,:uid,
    :provider])
  end
end
