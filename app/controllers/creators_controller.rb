class CreatorsController < ApplicationController
  def index
  end

  def new
  end

  def create
    @creators = Creator.new(creators_params)

    if @creators.save!
      #redirect_to root_url, notice: 'Add User'
    else
      render :new
    end
  end
  
  def show
    @user = User.find_by(id:params[:id])
    @creator = Creator.find_by(user_id:@user.id)
  end
  
  def edit
    @user = User.find(current_user.id)
    @creator = Creator.find_by(user_id:@user.id)
    
  end
  
  def update
    @creators = Creator.find(params[:id])
    if @creators.update(creators_params)
      redirect_to request.referer
    else
      render :new
    end
  end
  
  private

  def creators_params
    params.require(:creator).permit(:header,:icon,:update,:twitter,:pixiv,:deforume1,:deforume2,:deforume3,:sample,:checkbox)
  end   
end
