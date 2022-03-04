class CreatorsController < ApplicationController
  def show
    @user = User.find_by(id:params[:id])
    if user_signed_in?
      @login_user = User.find(current_user.id)
    end
  end
  
  def edit
    @user = User.find(current_user.id)
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
