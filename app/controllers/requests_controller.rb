class RequestsController < ApplicationController
  def new
    @request = Request.new
    @user = User.find(params[:id])
    @creator = Creator.find(params[:id])
  end
  
  def create
    @creators = Request.new(requests_params)

    if @creators.save!
      redirect_to root_url, notice: 'リクエストを送信しました。'
    else
      render :new
    end
  end
  
  private

  def requests_params
    params.require(:request).permit(:request_money, :request_message)
  end   
end
