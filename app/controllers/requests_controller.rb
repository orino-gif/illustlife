class RequestsController < ApplicationController
  before_action :authenticate_user!
  def new
    @requests = Request.new
     $receive_id=params[:id]
     #@send_id= current_user.id
    # @requests.save
    @user = User.find(params[:id])
    @creator = Creator.find(params[:id])
  end
  
  def create
    @requests = Request.new(requests_params)
    @creator = Creator.find(current_user.id)
    @requests.receive_id=$receive_id.to_i
    @requests.send_id=current_user.id.to_i
    @requests.status="START"
    if @requests.save!
      
      redirect_to root_url, notice: 'リクエストを送信しました。'
    else
      render :new
    end
  end
  
  def update
    @requests = Request.find(@requests.id)
    @creator = Creator.find(current_user.id)
    if @requests.update(requests_params)
      redirect_to root_url, notice: 'リクエストを送りました。'
    else
      render :new
    end
  end
  
  private

  def requests_params
    params.require(:request).permit(:request_money, :request_message)
  end   
end
