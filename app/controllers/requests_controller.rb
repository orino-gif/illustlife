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
    @requests.status="承認待ち"
    if @requests.save!
      $requests_id = @requests.id
      redirect_to request_url(@requests.send_id), notice: 'リクエストを送信しました。'
      #redirect_to root_url, notice: 'リクエストを送信しました。'
    else
      render :new
    end
  end
  
  def show
    @requests = Request.find($requests_id)
    @sender = User.find(@requests.send_id)
    @receiver = User.find(@requests.receive_id)
    
    
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
    params.require(:request).permit(:money, :message)
  end   
end
