class ExporsController < ApplicationController
  def new
    @expor = Expor.new
  end
  
  def create
    @expor = Expor.new(expors_params)
    if @expor.save
      
    end
  end
  
  private

  def expors_params
    params.require(:expor).permit(:cntri_id,:expo_img)
  end
end