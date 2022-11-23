class ExporsController < ApplicationController
  def new
    @expor = Expor.new
  end
  
  def create
    @expor = Expor.new(exposures_params)
    if @expor.save
      redirect_to expor_contributors_url(1,1)
    end
  end
  
  private

  def exposures_params
    params.require(:expor).permit(:cntri_id, :exp_img)
  end
end