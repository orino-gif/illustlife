class ExplanationsController < ApplicationController
  def index
    @explanations = Explanation.all
  end
  def new
    @explanations = Explanation.new
  end
  
  def create
    @explanations = Explanation.new(explanations_params)
    if @explanations.save
      redirect_to explanations_url, notice: '運営へフォームの内容を送信しました。'
    else
      render :new
    end
  end

  private
  
  def explanations_params
    params.require(:explanation).permit(:letter_body)
  end 
end
