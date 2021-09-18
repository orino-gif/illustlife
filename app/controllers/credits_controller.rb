class CreditsController < ApplicationController
  before_action :authenticate_user!
  def new
    @credits = Credit.find(current_user.id)
  end
  
  def create
    render :new
  end
  
  def show
    @credits = Credit.find(current_user.id)
  end
  
  def update
    @credits = Credit.find(current_user.id)
    if @credits.update(credits_params)
      redirect_to credit_url(@credits), notice: 'ファイルをアップロードしました。'
    else
      render :new
    end
  end
  
  private

  def credits_params
    params.require(:credit).permit(:bank, :branch_name, :account_type, :account_number, :account_holder)
  end
end
