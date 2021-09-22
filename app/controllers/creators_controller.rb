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
    params.require(:creator).permit(:header,:icon,:update,:twitter,:pixiv,:fg1,:fg2,:fg3,:fg_display,
    :bg_display,:cg_display,:bg1,:bg2,:bg3,:cg1,:cg2,:cg3)
  end   
end
