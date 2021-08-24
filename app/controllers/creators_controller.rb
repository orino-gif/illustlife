class CreatorsController < ApplicationController
  def index
    @creators = Creator.all
  end

  def new
    @creators = Creator.new
  end

  def create
    @creators = Creator.new(creators_params)

    if @creators.save
      #redirect_to root_url, notice: 'Add User'
    else
      render :new
    end
  end
  
  def show
    @user = User.find(1)
  end
  
  def edit
    @user = User.find(current_user.id)
    @creator = Creator.find_by(user_id:3)
  end
  
  private

  def creators_params
    params.fetch(:creator, {}).permit(:name, :image)
    params.require(:creator).permit(:name, :image, :image1, :image2)
  end   
end
