class CreatorsController < ApplicationController
  def index
    @creators = Creator.all
  end

  def new
    @creators = Creator.new
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
    @user = User.find(1)
  end
  
  def edit
    #@creators = Creator.new
    @user = User.find(current_user.id)
    @creator = Creator.find_by(user_id:@user.id)
    #@creator = Creator.find(12)
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
    #params.fetch(:creator, {}).permit(:name, :image)
    #params.require(:creator).permit(:image, :header)
    params.require(:creator).permit(:header,:update,:icon)
  end   
end
