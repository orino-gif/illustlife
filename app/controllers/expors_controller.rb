class ExporsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!, only: [:create]
  
  def index
    @expors = Expor.where(user_id: current_user.id)
  end
  
  def new
    @expor = Expor.new
  end
  
  def create
    @expor = Expor.new(expors_params)
    pfm = Pfm.find_by(cre_id: current_user.id)
    p @expor.who
    if '自分で' == @expor.who || pfm.point >= @expor.fee
      if '自分で' == @expor.who
        pfm.point += 5
      elsif 0 < @expor.fee || pfm.point <= @expor.fee
        pfm.point -= @expor.fee
      end
      pfm.save
      if '' != @expor.gist.to_s || 'NULL' != @expor.cmt
        @msg = Msg.new
        if '' != @expor.gist.to_s 
          @msg.s_msg = @expor.gist
          @msg.save
          @expor.msg_id = @msg.id
          @expor.gist = ''
        elsif 'NULL' != @expor.cmt
          @msg.s_msg = @expor.cmt
          @msg.save
          @expor.msg_id = @msg.id
          @expor.cmt = 'NULL'
        else
          p 'gist or s_msg error'
        end
      end
      if @expor.msg_id.nil? && @expor.e_img.nil?
        alt('作品が入力されていません')
      else
        if @expor.save
          redirect_to root_path, notice: '晒しました'
        elsif @expor.errors.full_messages[0].include?("e_dl.blank")
          alt('期限が入力されてません')
        else
          p @expor.errors.full_messages[0]
          alt('失敗しました')
        end
      end
    elsif pfm.point < @expor.fee
      alt('ポイントが足りません')
    end
  end
  
  def show
    @expor = Expor.find_by(id: params[:id])
  end
  
  def edit
    @expor = Expor.find_by(id: params[:id])
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
        Msg.find_by(id: @expor.msg_id).delete
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
    :gist, :who, :e_dl)
  end
end