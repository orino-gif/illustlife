class OvrsController < ApplicationController
  include ApplicationHelper
  include OvrsHelper
  before_action :authenticate_user!, only: [:create]
  def index
  end
  
  def new
    @ovr = Ovr.new
    @expor = Expor.find_by(id: params[:id])
  end
  
  def create
    @ovr = Ovr.new(ovrs_params)
    if @ovr.save
      redirect_to root_path, notice: '対応しました'
    elsif @ovr.errors.full_messages[0].include?("blank")
      redirect_to request.referer, alert: 'アップロードファイルが存在しません'
    else
      redirect_to request.referer
    end
  end
  
  def show
    @expor = Expor.find_by(id: params[:expor_id])
    @ovr = Ovr.find_by(id: params[:id])
  end

  def download
    ex_img(params[:expor_id])
  end
  
  def update
    @ovr = Ovr.find_by(id:params[:id])
    if @ovr.update(ovrs_params)
      redirect_to ovrs_path, notice: '更新しました。'
    end
  end
  private

  def ovrs_params
    params.require(:ovr).permit(:expor_id, :o_img, :up_id)
  end
end
