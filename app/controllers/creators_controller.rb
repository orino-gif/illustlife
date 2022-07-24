class CreatorsController < ApplicationController
  before_action :set_creator, only: [:show, :update, :edit]
  
  def show
    @requests = Request.where(receiver_id: @creator.user.id, status: '納品完了')
    if user_signed_in?
      @notification_users = Resume.where(notification_user:current_user.id)
    end
  end
  
  def earning
    
  end
  
  def edit
    @card = Card.find_by(user_id:params[:id])
    @credit = Credit.find_by(user_id:params[:id])
  end
  
  def update
    if @creator.update(creators_params)
      
      if params[:open]
        # 再開通知リストに登録されている者へ再開のメールを送る
        @resumes = Resume.where(resume_user: current_user.id)
        p @resumes
        if not @resumes.empty?
          @resumes.each do |id|
            @notification_user = User.find(id.notification_user)
            @resume_user = User.find(id.resume_user)
            UserMailer.info(@notification_user, @resume_user).deliver_later
          end
        end
      end
      
      redirect_to creator_path(params[:id]), notice: '登録情報を更新しました。'
    else
      p @creator.errors.full_messages
      if @creator.errors.full_messages[0].include?("amount")
        redirect_to request.referer, alert: '金額入力の数値が範囲外です'
      end
    end
  end
  
  private

  def creators_params
    params.require(:creator).permit(:header, :icon, :twitter, :pixiv, :instagram, :youtube, :link, :request_acceptance_permission, :recommended_amount, :minimum_amount, :nsfw)
  end

  def set_creator
    @creator = Creator.find(params[:id])
  end
end
