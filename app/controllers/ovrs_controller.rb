class OvrsController < ApplicationController
  include ApplicationHelper
  include OvrsHelper
  def index
  end
  
  def new
    @ovr = Ovr.new
    @expor = Expor.find_by(id: params[:id])
  end
  
  def create
    @ovr = Ovr.new(ovrs_params)
    if @ovr.save
      redirect_to expor_ovr_path(params[:expor_id],@ovr.id), notice: '上書きしました'
    end
  end
  
  def show
    @expor = Expor.find_by(id: params[:expor_id])
    @ovr = Ovr.find_by(id: params[:id])
  end
  
  def edit
    @ovr = Ovr.find_by(id: params[:id])
  end
  
  def download
    expor(params[:expor_id])
  end
  
  def update
    @ovr = Ovr.find_by(id:params[:id])
    if @ovr.update(ovrs_params)
      redirect_to ovrs_path, notice: '更新しました。'
    end
  end
  private

  def ovrs_params
    params.require(:ovr).permit(:expor_id, :o_img)
  end
end
