class ExplsController < ApplicationController
  # ログインしていない場合は、投稿させないで、ログイン画面へ移動させる
  before_action :authenticate_user!, only: [:new]
  
  def index
    @expls = Expl.all
  end
  
  def new
    @expl = Expl.new
  end
  
  def create
    @expl = Expl.new(expls_params)
    @expl.adv_id = current_user.id
    if @expl.save
      redirect_to expls_url, notice: '運営へご意見を送信しました。'
    else
      render :new
    end
  end

  private
  
  def expls_params
    params.require(:expl).permit(:adv_id, :a_msg)
  end
end
