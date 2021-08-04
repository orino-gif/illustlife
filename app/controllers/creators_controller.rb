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

  private

  def creators_params
    params.fetch(:creator, {}).permit(:name, :image)
    params.require(:creator).permit(:name, :image)
  end   
    
    
end
