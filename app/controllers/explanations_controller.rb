class ExplanationsController < ApplicationController
  def index
  end
  def new
    @explanations = Explanation.new
  end
  
  def create
    @explanations = Explanation.new
    if @explanations.save
      redirect_to explanations_url, notice: '運営へフォームの内容を送信しました。'
    else
      render :new
    end
  end
  
  def show
  end
end
