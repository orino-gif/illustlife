class RequestsController < ApplicationController
  before_action :authenticate_user!
  def new
    @requests = Request.new
    @user = User.find(params[:id])
    @creator = Creator.find(params[:id])
  end
  
  def create
    @requests = Request.new(requests_params)
  
    @creator = Creator.find(current_user.id)
    if @requests.save!
      @requests.send_id = @creator.user_id
      @requests.status = request.url
      @requests.save
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
