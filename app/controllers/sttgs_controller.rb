class SttgsController < ApplicationController
  def update
    @sttg =  Sttg.find_by(cre_id: params[:id])
    if @sttg.update(sttgs_params)
      redirect_to "/reqs/#{params[:id]}/new", notice: '設定情報を更新しました。'
    end
  end
  
  private
  def sttgs_params
    params.require(:sttg).permit(:recom,:min,:work_d,:start,:nsfw,:job)
  end
end
