class SttgsController < ApplicationController
  def update
    @sttg =  Sttg.find_by(cre_id: params[:id])
    if @sttg.update(sttgs_params)
      redirect_to cre_path(params[:id]), notice: '設定情報を更新しました。'
    end
  end
  
  private
  def sttgs_params
    params.require(:sttg).permit(:recom,:min,:work_d,:start,:nsfw)
  end
end
