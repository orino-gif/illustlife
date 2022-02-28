class CreatorsController < ApplicationController
  def show
    @user = User.find_by(id:params[:id])
  end
  
  def edit
    @user = User.find(current_user.id)
  end
  
  def update
    begin
      @creators = Creator.find(params[:id])
      @creators.update(creators_params)
      redirect_to request.referer, notice: '登録情報を更新しました。'
    rescue => e
     p e
     redirect_to request.referer, alert: 'ファイルを選択してください'
    end
  end
  
  private

  def creators_params
    params.require(:creator).permit(:header, :icon, :twitter, :pixiv, :instagram)
  end   
end
