class ExposuresController < ApplicationController
  def index
  end
  
  def new
    @expsr = Expsr.new
  end
  
  def create
    @expsr = Expsr.new(expsrs_params)
    if @expsr.save
      redirect_to expsr_contributors_url(1,1)
    end
  end

  def show
  end
  
  private

  def expsrs_params
    params.require(:expsr).permit(:cntri_id, :expo_img)
  end
end
