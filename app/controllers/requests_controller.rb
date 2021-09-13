class RequestsController < ApplicationController
  before_action :authenticate_user!
  def new
    @requests = Request.new
    # @temporary = Temporary.new
    # @temporary.temp_id = params[:id]
    # @temporary.save
    @requests.receive_id=params[:id]
    @requests.send_id= current_user.id
    @requests.save
    @user = User.find(params[:id])
    @creator = Creator.find(params[:id])
  end
  
  def create
    @requests = Request.new(requests_params)
    if @requests.save!
      redirect_to root_url, notice: 'リクエストを送信しました。'
    else
      render :new
    end
  end
  
  def update
    @requests = Request.find_by(id:33, send_id:current_user.id)
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
