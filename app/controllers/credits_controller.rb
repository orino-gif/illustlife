class CreditsController < ApplicationController
  before_action :authenticate_user!
  
  # @credits = Credit.find(params[:id])をセット
  before_action :set_credits, only: [:new, :show, :update]

  def update
    @credits = Credit.find(params[:id])
    
    if @credits.update(credits_params)
      redirect_to credit_url(@credits), notice: '登録を変更しました。'
    else
      redirect_to request.referer, alert: '口座番号に誤りがあります'
    end
  end
  
  private

  def credits_params
    params.require(:credit).permit(:bank, :branch, :account_type, :number, :holder)
  end
  
  def set_credits
    @credits = Credit.find(params[:id])
  end
end
