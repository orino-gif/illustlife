class OvrsController < ApplicationController
  include ApplicationHelper
  include OvrsHelper
  before_action :authenticate_user!, only: [:new, :create]
  
  def index
  end
  
  def new
    @expor = Expor.find_by(id: params[:expor_id])
    @ovr = Ovr.new
  end
  
  def create
    @ovr = Ovr.new(ovrs_params)
    expor = Expor.find_by(id: params[:expor_id])
    if @ovr.save
      if '誰かに' == expor.who
        expor.w_st = '協力中'
      end
      expor.save
      redirect_to edit_expor_ovr_path(expor.id, @ovr.id), notice: '開始しました'
    elsif @ovr.errors.full_messages[0].include?("blank")
      redirect_to request.referer, alert: 'アップロードファイルが存在しません'
    else
      alt('失敗しました')
    end
  end
  
  def show
    @expor = Expor.find_by(id: params[:expor_id])
    @ovr = Ovr.find_by(id: params[:id])
  end
  
  def edit
    @expor = Expor.find_by(id: params[:expor_id])
    @ovr = Ovr.find_by(id: params[:id])
  end

  def download
    p params[:ovr_id]
    eo_img(params[:expor_id], params[:ovr_id])
  end
  
  def update
    @ovr = Ovr.find_by(id:params[:id])
    if @ovr.update(ovrs_params)
      @ovr.expor.w_st = '完了'
      @ovr.expor.save
      redirect_to root_path, notice: '更新しました'
    end
  end
  
  def destroy
    ovr = Ovr.find_by(id: params[:id])
    if ovr.delete
      redirect_to root_path, notice: '削除しました'
    end
  end
  
  private

  def ovrs_params
    params.require(:ovr).permit(:expor_id, :o_img, :up_id)
  end
end
