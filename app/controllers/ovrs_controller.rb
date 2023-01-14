class OvrsController < ApplicationController
  include ApplicationHelper
  include OvrsHelper
  before_action :authenticate_user!, only: [:new, :create]
  
  def new
    @expor = Expor.find_by(id: params[:expor_id])
    @ovr = Ovr.new
  end
  
  def create
    @ovr = Ovr.new(ovrs_params)
    @expor = Expor.find_by(id: params[:expor_id])
    if @ovr.save
      if '自分で' == @expor.who
        @expor.w_st = '作業中'
      elsif '誰かに' == @expor.who
        @expor.w_st = '協力中'
        @tx = User.find_by(id: @ovr.up_id)
        @rx = User.find_by(id: @expor.user_id)
        UserMailer.col(@tx, @rx, @expor, @ovr).deliver_later
      end
      @expor.save
      redirect_to edit_expor_ovr_path(@expor.id, @ovr.id),notice: '開始しました'
    elsif @ovr.errors.full_messages[0].include?("blank")
      redirect_to request.referer, alert: 'アップロードファイルが存在しません'
    else
      alt('失敗しました')
    end
  end
  
  def show
    @expor = Expor.find_by(id: params[:expor_id])
    @ovr = Ovr.find_by(id: params[:id])
  end
  
  def edit
    @expor = Expor.find_by(id: params[:expor_id])
    p params[:btn]
    if '手戻し'== params[:btn]
      @expor.w_st = params[:btn]
      @expor.save
    end
    @ovr = Ovr.find_by(id: params[:id])
    @cre = Cre.find_by(user_id: @expor.user_id)
  end

  def down
    eo_img(params[:expor_id], params[:ovr_id])
  end
  
  def update
    @expor = Expor.find_by(id: params[:expor_id])
    w_st = @expor.w_st
    @ovr = Ovr.find_by(id:params[:id])
    if @ovr.update(ovrs_params)
      @expor.w_st = '完了'
      @expor.save
      if '手戻し' != w_st
        pfm = Pfm.find_by(cre_id: @ovr.up_id)
        pfm.point += @expor.fee.abs
        pfm.save
        if '誰かに' == @expor.who
          @users = User.find(@ovr.up_id, @expor.user_id)
          @rx = User.find_by(id: @expor.user_id)
          UserMailer.comp(@users[0], @users[1],@expor,@ovr).deliver_later
        end
        redirect_to root_path, notice: @expor.fee.abs.to_s + 'pt獲得しました'
      else
        redirect_to expors_path, notice: '手戻ししました'
      end
    end
  end
  
  def destroy
    ovr = Ovr.find_by(id: params[:id])
    tx = User.find_by(id: ovr.expor.user_id)
    rx = User.find_by(id: ovr.up_id)
    if ovr.delete
      UserMailer.inter(tx, rx, ovr.expor).deliver_later
      redirect_to root_path, notice: '中断しました'
    end
  end
  
  private

  def ovrs_params
    params.require(:ovr).permit(:expor_id, :o_img, :up_id)
  end
end
