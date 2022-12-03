class ExporsController < ApplicationController
  def new
    @expor = Expor.new
  end
  
  def create
    @expor = Expor.new(expors_params)
    if @expor.save
      redirect_to root_path, notice: '晒しました'
    end
  end
  
  private

  def expors_params
    params.require(:expor).permit(:user_id, :e_img)
  end
end