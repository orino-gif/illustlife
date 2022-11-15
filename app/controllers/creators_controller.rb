class CreatorsController < ApplicationController
  
  # @creator = Creator.find(params[:id]) が記載されている関数
  before_action :set_creator, only: [:show, :update, :edit, :earning]
  
  
  def show
    # 納品済みの作品を表示する為に利用
    @requests = Request.where(rx_id: @creator.user.id, status: '納品完了')
    # @works = Work.find_by(request_id:66)
    # @works = Work.find(66,67,68)#プライマリーを設定している場合
    # @works = Work.find_by(request_id:66)
    # @works = Work.all
    # @works = Request.joins(:work)

  end
  
  def edit
    @setting =  Setting.find_by(creator_id: params[:id])
    p @setting
    
    # カード登録情報の有無を確認する為に利用
    # Card.find(params[:id])だと、NothingErrになる為、find_byを使用
    @card =  Card.find_by(user_id: params[:id])
    
    # 口座登録情報の有無を確認する為に利用
    credit = Credit.find_by(user_id:params[:id])
    
    if credit["bank"] && credit["branch"] && credit["account_type"] \
      && credit["number"] && credit["holder"]
      @is_credit_all = true
    end
  end
  
  # 総売上と引き落とし可能額を表示し、引き落とし申請を行う。
  def earning 
    if @withdrawal_status.nil?
      @withdrawal_status = '引き落とし申請前'
    end
      
    if '引き落とし内容確認' == params[:withdrawal_status]
      if @creator.performance.withdrawal > 0
        @withdrawal_status = '引き落とし内容確認'
      else
        flash.now[:alert] = '引き落とし対象額が0円です'
          render :earning
      end
      
    elsif '引き落とし実行' == params[:withdrawal_status]
      @withdrawal_status = '引き落とし実行'
      UserMailer.wdl(@creator).deliver_later
      sleep(5)
      @creator.performance.withdrawal = 0
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
            
            UserMailer.resume(@notification_user,
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
      :youtube, :link)
  end

  def set_creator
    @creator = Creator.joins(:performance).find(params[:id])
  end
end
