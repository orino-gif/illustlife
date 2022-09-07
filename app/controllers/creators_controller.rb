class CreatorsController < ApplicationController
  
  # @creator = Creator.find(params[:id]) が記載されている関数
  before_action :set_creator, only: [:show, :update, :edit, :earning]
  
  
  def show
    # 納品済みの作品を表示する為に利用
    @requests = Request.where(receiver_id: @creator.user.id, status: '納品完了')
  end
  
  def edit
    # カード登録情報の有無を確認する為に利用
    @card = Card.find(params[:id])
    
    # 口座登録情報の有無を確認する為に利用
    credit = Credit.find_by(user_id:params[:id])
    
    if credit["bank"] && credit["branch_name"] && credit["account_type"] \
      && credit["account_number"] && credit["account_holder"]
      @is_credit_all = true
    end
  end
  
  # 総売上と引き落とし可能額を表示し、引き落とし申請を行う。
  def earning 
    if @withdrawal_status.nil?
      @withdrawal_status = '引き落とし申請前'
    end
      
    if '引き落とし内容確認' == params[:withdrawal_status]
      @withdrawal_status = '引き落とし内容確認'
      
    elsif '引き落とし実行' == params[:withdrawal_status]
      @withdrawal_status = '引き落とし実行'
      UserMailer.info_withdrawal(@creator).deliver_later
      sleep(5)
      @creator.withdrawal_amount = 0
      @creator.save
    end
  end
  
  def update
    if @creator.update(creators_params)
      
      # リクエスト受付開始ボタンが押された場合
      if params[:accepting_requests]
        
        # 通知リストに登録されている者をリストアップ
        notification_users = Resume.where(resume_user: current_user.id)
        
        # 再開通知リストに登録されている者へ再開のメールを送る
        if notification_users
          notification_users.each do |user|
            @notification_user = User.find(user.notification_user)
            @resume_user = User.find(user.resume_user)
            UserMailer.resume_info(@notification_user,
              @resume_user).deliver_later
          end
        end
        
      end
      
      redirect_to creator_path(params[:id]), notice: '登録情報を更新しました。'
      
    else # ユーザー編集後の値の保存に失敗した場合
    
      p @creator.errors.full_messages[0]
      
      if @creator.errors.full_messages[0].include?("amount")
        flash.now[:alert] = "金額入力の数値が範囲外です" 
        render :edit
          
      elsif @creator.errors.full_messages[0].include?("whitelist_error")
        flash.now[:alert] = "非対応のファイル形式です(対応:png,jpg,jpeg,gif)" 
        render :edit
      end
    end
  end
  
  private

  def creators_params
    params.require(:creator).permit(:header, :icon, :twitter, :pixiv, :instagram,
      :youtube, :link, :request_acceptance_permission, :recommended_amount,
      :working_days, :minimum_amount, :nsfw, :temp_img)
  end

  def set_creator
    @creator = Creator.find(params[:id])
  end
end
