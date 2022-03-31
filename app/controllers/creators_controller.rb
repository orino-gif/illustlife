class CreatorsController < ApplicationController
  def show
    @authorizer = User.find_by(id:params[:id])
    @requests = Request.where(receiver: current_user.nickname, status:'納品完了')
  end
  
  def edit
    @authorizer = User.find_by(id:params[:id])
  end
  
  def update
    begin
      @creators = Creator.find(params[:id])
      @creators.update(creators_params)
      redirect_to creator_path(params[:id]), notice: '登録情報を更新しました。'
    rescue => e
     p e
     redirect_to request.referer, alert: 'ファイルを選択してください'
    end
  end
  
  private

  def creators_params
    params.require(:creator).permit(:header, :icon, :twitter, :pixiv, :instagram, :request_acceptance_permission, :recommended_amount)
  end   
end
