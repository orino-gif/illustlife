class ExposuresController < ApplicationController
  def index
  end
  
  def new
    @exposure = Exposure.new
  end
  
  def create
    @exposure = Exposure.new(exposures_params)
    if @exposure.save
      redirect_to exposures_url
    end
  end

  def show
    
  end
  
  
  private

  def exposures_params
    params.require(:exposure).permit(:contributor_id, :exposed_img)
  end
end
