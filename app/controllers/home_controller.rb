class HomeController < ApplicationController
  def index
    @users = User.all
    @creators = Creator.all
  end
  
  def show
    @user = User.find_by(id:params[:id])
    @creator = Creator.find_by(user_id:@user.id)
  end
end
