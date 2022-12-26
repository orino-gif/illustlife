class ExporsController < ApplicationController
  include ApplicationHelper
  def index
    @expors = Expor.where(user_id: current_user.id)
  end
  
  def new
    @expor = Expor.new
  end
  
  def create
    @expor = Expor.new(expors_params)
    if @expor.save
      redirect_to expors_path(@expor.user_id), notice: '晒しました'
    end
  end
  
  def show
    @expor = Expor.find_by(id: params[:id])
  end
  
  def edit
    @expor = Expor.find_by(id: params[:id])
  end
  
  def update
    @expor = Expor.find_by(id:params[:id])
    if @expor.update(expors_params)
      redirect_to expors_path, notice: '更新しました。'
    end
  end
  
  def destroy
    @expor = Expor.find_by(id: params[:id])
    if @expor.delete
      noti('削除しました')
    end
  end
  
  private

  def expors_params
    params.require(:expor).permit(:user_id, :e_img, :kind, :hope, :fee, :gist)
  end
end