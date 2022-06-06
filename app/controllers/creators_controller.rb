class CreatorsController < ApplicationController
  before_action :set_authorizer, only: [:show, :edit]
  def show
  end
  
  def edit
    @card = Card.find_by(user_id:params[:id])
    @credit = Credit.find_by(user_id:params[:id])
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
  
  def set_authorizer
    @authorizer = User.find_by(id:params[:id])
  end
end
