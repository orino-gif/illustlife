class CreatorsController < ApplicationController
  before_action :set_authorizer, only: [:show, :edit]
  before_action :set_creator, only: [:show, :update]
  
  def show
    @requests = Request.where(receiver_id: @creator.user.id, status: '納品完了')
    @notification_users = Resume.where(notification_user:current_user.id)
  end
  
  def edit
    @card = Card.find_by(user_id:params[:id])
    @credit = Credit.find_by(user_id:params[:id])
  end
  
  def update
    begin
      @creator.update(creators_params)
      if @creator.request_acceptance_permission
        UserMailer.info.deliver_later
      end
      redirect_to creator_path(params[:id]), notice: '登録情報を更新しました。'
    rescue => e
      p e
      redirect_to request.referer, alert: 'ファイルを選択してください'
    end
  end
  
  private

  def creators_params
    params.require(:creator).permit(:header, :icon, :twitter, :pixiv, :instagram, :request_acceptance_permission, :recommended_amount, :minimum_amount, :nsfw)
  end
  
  def set_authorizer
    @authorizer = User.find_by(id:params[:id])
  end
  
  def set_creator
    @creator = Creator.find(params[:id])
  end
end
