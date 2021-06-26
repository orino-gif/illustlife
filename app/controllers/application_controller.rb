class ApplicationController < ActionController::Base
# default url
  before_action :authenticate_user!
end
