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
    if '自分で(+5pt)' == @expor.who || pfm.point >= @expor.fee
      if '自分で(+5pt)' == @expor.who
        pfm.point += 5
      elsif 0 < @expor.fee || pfm.point <= @expor.fee
        pfm.point -= @expor.fee
      end
      pfm.save
      @msg = Msg.new
      @msg.s_msg = @expor.gist
      @msg.save
      @expor.msg_id = @msg.id
      @expor.gist = ''
      if @expor.save
        redirect_to root_path, notice: '晒しました'
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
    if @expor.update(expors_params)
      redirect_to expors_path, notice: '更新しました。'
    end
  end
  
  def destroy
    @expor = Expor.find_by(id: params[:id])
    pfm = Pfm.find_by(cre_id: @expor.user_id)
    pfm.point += @expor.fee
    if '自分で(+5pt)' == @expor.who 
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