class CresController < ApplicationController
  before_action :set_cre, only: [:show, :edit, :earning, :update]
  include ApplicationHelper
  def show
    @reqs = Req.where(rx_id: params[:id], stts: '納品')
    @expors = Expor.where(user_id: params[:id])
    @ovrs = Ovr.where(up_id: params[:id])
  end
  def edit
    @sttg = Sttg.find_by(cre_id: params[:id])
    @card =  Card.find_by(user_id: params[:id])
    cr = Cr.find_by(user_id: params[:id])
    if cr["bank"] && cr["branch"] && cr["a_type"] && cr["number"] \
    && cr["holder"]
    @is_cr_all = true
    end
  end
  def earning 
    if @wdl_status.nil?; @wdl_status = '引き落とし申請前';end
    if '引き落とし内容確認' == params[:wdl_status]
      if @cre.pfm.wdl > 0
        @wdl_status = '引き落とし内容確認'
      else
        flash.now[:alert] = '引き落とし対象額が0円です'
        render :earning
      end
    elsif '引き落とし実行' == params[:wdl_status]
      @wdl_status = '引き落とし実行'
      UserMailer.wdl(@cre).deliver_later; sleep(5)
      @cre.pfm.wdl=0
      @cre.save
    end
  end
  
  def update
    if @cre.update(cres_params)
      if params[:acept_req]
        if noti_ids = Resm.where(re_id: current_user.id)
          noti_ids.each do |user|
            @noti_id = User.find(user.noti_id)
            @re_id = User.find(user.re_id)
            UserMailer.resm(@noti_id ,@re_id).deliver_later
          end
        end
      end
      noti('登録情報を更新しました。', cre_path(params[:id]))
    else
      p @cre.errors.full_messages[0]
      if @cre.errors.full_messages[0].include?("amount")
        flash.now[:alert] = "金額入力の数値が範囲外です" 
      elsif @cre.errors.full_messages[0].include?("whitelist_error")
        flash.now[:alert] = "非対応のファイル形式です(対応:png,jpg,jpeg,gif)"
      else 
      flash.now[:alert] = "入力ファイルが非対応です"
      end
      render :edit
    end
  end
  
  private
  def cres_params
    params.require(:cre).permit(:hdr,:icon,:twtr,:pixiv,:insta,:yt,:link)
  end
  def set_cre
    @cre = Cre.find(params[:id])
  end
end