class RequestsController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  
  def index
    begin
      @request = Request.find_by(sender: @current_user.nickname)
      if @request == nil
        @request = Request.find_by(receiver: @current_user.nickname)
      end
      
      @current_user = User.find(current_user.id)
      @requests = Request.where(receiver: @request.receiver).or(Request.where(sender: @request.sender))
      @sender = User.find_by(nickname: @request.sender)
      @receiver = User.find_by(nickname: @request.receiver)
      
      if params[:pressed] == 'ON'
        @request = Request.find(params[:request_id])
        @request.status = params[:status]
        if @request.save
          if '拒否' == params[:status]
            UserMailer.refusal_email(@sender, @receiver, @request).deliver_later
            redirect_to requests_url, notice: '依頼者からのリクエストを拒否するメールを送信しました。'
            
          elsif '製作中' == params[:status]
            UserMailer.consent_email(@sender, @receiver, @request).deliver_later
            redirect_to requests_url, notice: '依頼者へ承諾のメールを送信しました。'
            
          elsif '納品完了' == params[:status]
            UserMailer.deliver_email(@sender, @receiver, @request).deliver_later
            redirect_to requests_url, notice: '依頼者への納品完了のメールを送信しました。'
          end
        end
      end
    
    rescue => e
      p "エラー：#{e}"
    end
  end
  
  def new
    @requests = Request.new
    $receive_id = params[:id]
    @user = User.find(params[:id])
    @creator = Creator.find(params[:id])
  end
  
  def create
    if user_signed_in?
      @requests = Request.new(requests_params)
      @sender = User.find(current_user.id)
      @receiver = User.find($receive_id.to_i)
      @requests.sender = @sender.nickname
      @requests.receiver = @receiver.nickname
      @requests.status = "承認待ち"
      
      if @requests.save!
        UserMailer.request_email(@sender,@receiver,@requests).deliver_later
        redirect_to request_url(@sender), notice: 'クリエイターへリクエストのメールを送信しました。'
      else
        render :new
      end
    else
      redirect_to  '/users/sign_in', notice: 'ユーザー登録とログインが必要です。'
    end
  end
  
  def show
    @request = Request.find(params[:id])
  end
  
  def update
    @requests = Request.find(params[:request][:request_id])
    if @requests.update(requests_params)
      redirect_to requests_url, notice: 'ファイルをアップロードしました。'
    else
      render :new
    end
  end
  
  private

  def requests_params
    params.require(:request).permit(:money, :message, :deliver_img)
  end
  
end
