class CreatorsController < ApplicationController
  # @cre = Creator.find(params[:id]) が記載されている関数
  before_action :set_creator, only: [:show, :update, :edit, :earning]
  
  def show
    @reqs = Request.where(rx_id: params[:id], stts: '納品')
  end
  
  def edit
    @setting =  Setting.find_by(creator_id: params[:id])
    @card =  Card.find_by(user_id: params[:id])
    credit = Credit.find_by(user_id:params[:id])
    if credit["bank"] && credit["branch"] && credit["a_type"] \
      && credit["number"] && credit["holder"]
      @is_credit_all = true
    end
  end

  def earning 
    if @wdl_status.nil?
      @wdl_status = '引き落とし申請前'
    end
    if '引き落とし内容確認' == params[:wdl_status]
      if @cre.performance.wdl > 0
        @wdl_status = '引き落とし内容確認'
      else
        flash.now[:alert] = '引き落とし対象額が0円です'
        render :earning
      end
    elsif '引き落とし実行' == params[:wdl_status]
      @wdl_status = '引き落とし実行'
      UserMailer.wdl(@cre).deliver_later
      sleep(5)
      @cre.performance.wdl = 0
      @cre.save
    end
  end
  
  def update
    if @cre.update(creators_params)
      if params[:accepting_requests]
        noti_ids = Resume.where(re_id: current_user.id)
        if noti_ids
          noti_ids.each do |user|
            @noti_id = User.find(user.noti_id)
            @re_id = User.find(user.re_id)
            UserMailer.resume(@noti_id,@re_id).deliver_later
          end
        end
      end
      redirect_to creator_path(params[:id]), notice: '登録情報を更新しました。'
    else
      p @cre.errors.full_messages[0]
      if @cre.errors.full_messages[0].include?("amount")
        flash.now[:alert] = "金額入力の数値が範囲外です" 
        render :edit
      elsif @cre.errors.full_messages[0].include?("whitelist_error")
        flash.now[:alert] = "非対応のファイル形式です(対応:png,jpg,jpeg,gif)" 
        render :edit
      end
    end
  end
  
  private
  def creators_params
    params.require(:creator).permit(:hdr,:icon,:twtr,:pixiv,:insta,:yt,:link)
  end
  def set_creator
    @cre = Creator.find(params[:id])
  end
end