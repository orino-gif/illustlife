class HomeController < ApplicationController
  def index
    @users = User.all
    
    
  end
  
  def show
    # @user = User.find(params[:id])
    @user = User.find_by(id:params[:id])
    @creator = Creator.find_by(user_id:@user.id)
    #logger.debug{@creator.name}
  end
end
