class CrsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_crs, only: [:new, :show, :update]
  def update
    @crs = Cr.find(params[:id])
    if @crs.update(crs_params)
      redirect_to cr_url(@crs), notice: '登録を変更しました。'
    else
      redirect_to request.referer, alert: '口座番号に誤りがあります'
    end
  end
  
  private

  def crs_params
    params.require(:cr).permit(:bank, :branch, :a_type, :number, :holder)
  end
  
  def set_crs
    @crs = Cr.find(params[:id])
  end
end
