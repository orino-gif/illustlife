class ExporsController < ApplicationController
  def index
    @expors = Expor.find_by(user_id: current_user.id)
  end
  
  def new
    @expor = Expor.new
  end
  
  def create
    @expor = Expor.new(expors_params)
    if @expor.save
      redirect_to cre_path(@expor.user_id), notice: '晒しました'
    end
  end
  
  def show
    @expor = Expor.find_by(id: params[:id])
  end
  
  private

  def expors_params
    params.require(:expor).permit(:user_id, :e_img)
  end
end