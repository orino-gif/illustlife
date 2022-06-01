class CreditsController < ApplicationController
  before_action :authenticate_user!
  def new
    @credits = Credit.find(params[:id])
  end
  
  def show
    @credits = Credit.find(params[:id])
  end
  
  def update
    @credits = Credit.find(params[:id])
    if @credits.update(credits_params)
      redirect_to credit_url(@credits), notice: '登録を変更しました。'
    else
      render :new
    end
  end
  
  private

  def credits_params
    params.require(:credit).permit(:bank, :branch_name, :account_type, :account_number, :account_holder)
  end
end
