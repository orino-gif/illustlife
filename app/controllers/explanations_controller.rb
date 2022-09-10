class ExplanationsController < ApplicationController
  # ログインしていない場合は、投稿させないで、ログイン画面へ移動させる
  before_action :authenticate_user!, only: [:new]
  
  def index
    @explanations = Explanation.all
  end
  
  def new
    @explanations = Explanation.new
  end
  
  def create
    @explanations = Explanation.new(explanations_params)
    @explanations.adviser_id = current_user.id

    if @explanations.save
      redirect_to explanations_url, notice: '運営へご意見を送信しました。'
    else
      render :new
    end
  end

  private
  
  def explanations_params
    params.require(:explanation).permit(:adviser_id, :letter_body)
  end 
end
