class ExporsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!, only: [:create]
  
  def index
    @expors = Expor.where(user_id: current_user.id)
    @ovrs = Ovr.where(up_id: current_user.id)
  end
  
  def new
    @expor = Expor.new
  end
  
  def create
    @expor = Expor.new(expors_params)
    pfm = Pfm.find_by(cre_id: current_user.id)
    if pfm.point >= @expor.fee
      if '' != @expor.gist || @expor.e_img?
        p @expor.gist.length
        if 1000 > @expor.gist.length.to_i
          if '' != @expor.gist
            @msg = Msg.new
            @msg.s_msg = @expor.gist
            @msg.save
            @expor.msg_id = @msg.id
            @expor.gist = ''
          end
          if '自分で' == @expor.who
            pfm.point += 5
            @expor.w_st = '作業中'
          else
            pfm.point -= @expor.fee
            @expor.w_st = '待機'
          end
          if @expor.save
            pfm.save
            redirect_to root_path, notice: '晒しました'
          elsif @expor.errors.full_messages[0].include?("e_dl.blank")
            alt('期限が入力されてません')
          elsif @expor.errors.full_messages[0].include?("以前に")
            err_msg = @expor.errors.full_messages[0].slice(6..30)
            alt('日付は' + (Date.today+1).to_s + '以降～' + err_msg)
          elsif @expor.errors.full_messages[0].include?("cmt.blank")
            alt('一言が空白です')
          elsif @expor.errors.full_messages[0].include?("cmt.too_long")
            alt('一言が17文字を超えています')
          else
            p @expor.errors.full_messages[0]
            alt('失敗しました')
          end
        else
          alt('テキスト文字数が1000を超えています')
        end
      else
        alt('作品が入力されていません')
      end
    else
      alt('ポイントが足りません')
    end
  end
  
  def show
    @expor = Expor.find_by(id: params[:id])
  end
  
  def edit
    @expor = Expor.find_by(id: params[:id])
    illust = "キャラデザ,背景デザ,構図,ラフ,線画,塗り(色分け),塗り(着色),納品"
    if illust.include?(@expor.kind)
      @illust = true
    else
      @illust = false
    end
  end
  
  def update
    @expor = Expor.find_by(id: params[:id])
    p 'test1' + @expor.who.to_s
    who = @expor.who
    if @expor.update(expors_params)
      pfm = Pfm.find_by(cre_id: current_user.id)
      if '自分で' == who && '誰かに' == @expor.who
        pfm.point -= 5
        pfm.point -= @expor.fee
      elsif '誰かに' == who && '自分で' == @expor.who
        pfm.point += 5
        pfm.point += @expor.fee
      end
      p 'test3' + @expor.gist.to_s
      if '' != @expor.gist
        if @expor.msg_id?
          Msg.find_by(id: @expor.msg_id).delete
          @expor.msg_id = 'NULL'
        end
        @msg = Msg.new
        @msg.s_msg = @expor.gist
        @msg.save
        @expor.msg_id = @msg.id
        @expor.gist = ''
      end
      pfm.save
      @expor.save
      p 'test2' + @expor.who.to_s
      redirect_to expors_path, notice: '更新しました。'
    end
  end
  
  def destroy
    @expor = Expor.find_by(id: params[:id])
    ovr = Ovr.find_by(expor_id: @expor.id)
    if ovr
      ovr.delete
    end
    pfm = Pfm.find_by(cre_id: @expor.user_id)
    pfm.point += @expor.fee
    
    if '自分で' == @expor.who 
      pfm.point -= 5
    end
    pfm.save
    
    if @expor.delete
      noti('削除しました')
    end
  end
  
  private

  def expors_params
    params.require(:expor).permit(:user_id, :e_img, :kind, :hope, :fee,
    :gist, :who, :e_dl, :cmt, :w_st)
  end
end