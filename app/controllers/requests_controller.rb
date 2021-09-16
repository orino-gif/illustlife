class RequestsController < ApplicationController
  before_action :authenticate_user!
  def new
    @requests = Request.new
    $receive_id=params[:id]
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
      @sender = User.find(@requests.send_id)
      @receiver = User.find(@requests.receive_id)
      
      UserMailer.request_email(@sender,@receiver,@requests).deliver_later
      redirect_to request_url(@sender), notice: 'クリエイターへリクエストのメールを送信しました。'
      
      $requests_id = @requests.id
    else
      render :new
    end
  end
  
  def show
    begin
      @requests = Request.find($requests_id)
      @sender = User.find(@requests.send_id)
      @receiver = User.find(@requests.receive_id)
    rescue => e
      p "showコントローラーエラー：#{e}"
    end
    
    if '拒否' == params[:status]
      @requests.status = params[:status]
      if @requests.save
        redirect_to request_url(@receiver), notice: '依頼者からのリクエストを拒否しました。'
      end
    elsif '製作中' == params[:status]
      @requests.status = params[:status]
      if @requests.save
        UserMailer.consent_email(@sender, @receiver, @requests).deliver_later
        redirect_to request_url(@receiver), notice: '依頼者へ承諾のメールを送信しました。'
      end
      
    elsif '納品完了' == params[:status]
      @requests.status = params[:status]
      if @requests.save
        UserMailer.deliver_email(@sender, @receiver, @requests).deliver_later
        redirect_to request_url(@receiver), notice: '依頼者への納品完了のメールを送信しました。'
      end
    end
  end
  
  def update
    @requests = Request.find($requests_id)
    if @requests.update(requests_params)
      redirect_to request_url(@requests), notice: 'ファイルをアップロードしました。'
    else
      render :new
    end
  end
  
  private

  def requests_params
    params.require(:request).permit(:money, :message, :deliver_img)
  end
  
  
end
