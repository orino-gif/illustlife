class CreditsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_credits, only: [:new, :update]
  
  def new
  end
  
  def show
    @credits = Credit.find(params[:id])
  end
  
  def update
    if @credits.update(credits_params)
      redirect_to credit_url(@credits), notice: '登録を変更しました。'
    else
      redirect_to request.referer, alert: '口座番号に誤りがあります'
    end
  end
  
  private

  def credits_params
    params.require(:credit).permit(:bank, :branch_name, :account_type, :account_number, :account_holder)
  end
  
  def set_credits
    @credits = Credit.find(current_user.id)
  end
end
