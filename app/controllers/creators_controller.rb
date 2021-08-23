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
      redirect_to root_url, notice: 'Add User'
    else
      render :new
    end
  end
  
  def show
    @user = User.find(1)
  end

  private

  def creators_params
    params.require(:creator).permit(:header)
  end   
    
    
end
