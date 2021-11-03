class RequestsController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def new
    @requests = Request.new
    $receive_id=params[:id]
    @user = User.find(params[:id])
    @creator = Creator.find(params[:id])
  end
  
  def create
    if user_signed_in?
      @requests = Request.new(requests_params)
      #@creator = Creator.find(current_user.id)
      @sender=User.find(current_user.id)
      @receiver=User.find($receive_id.to_i)
      @requests.sender=@sender.nickname
      @requests.receiver=@receiver.nickname
      @requests.status="承認待ち"
      
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
    begin
      @current_user = User.find(current_user.id)
      if params[:pressed] == 'ON'
        @request = Request.find(params[:request_id])
      else
        @request = Request.find_by(sender: @current_user.nickname)
        if @request == nil
          @request = Request.find_by(receiver: @current_user.nickname)
        end
      end
      p @request 

      @requests = Request.where(receiver: @request.receiver).or(Request.where(sender: @request.sender))
      @sender = User.find_by(nickname: @request.sender)
      @receiver = User.find_by(nickname: @request.receiver)
    rescue => e
      p "エラー：#{e}"
    end
    
    if '拒否' == params[:status]
      @request.status = params[:status]
      if @request.save
        UserMailer.refusal_email(@sender, @receiver, @request).deliver_later
        redirect_to request_url(@request), notice: '依頼者からのリクエストを拒否するメールを送信しました。'
      end
    elsif '製作中' == params[:status]
      
      p "リクエストステータス：#{@request.status}"
      @request.status = params[:status]
      if @request.save
        # 承認者から依頼者へ承諾メールの送信
        UserMailer.consent_email(@sender, @receiver, @request).deliver_later
        redirect_to request_url(@user), notice: '依頼者へ承諾のメールを送信しました。'
      end
      
    elsif '納品完了' == params[:status]
      @request.status = params[:status]
      if @request.save
        UserMailer.deliver_email(@sender, @receiver, @request).deliver_later
        redirect_to request_url(@request), notice: '依頼者への納品完了のメールを送信しました。'
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
  
  def report
    render :new
  end
  
  private

  def requests_params
    params.require(:request).permit(:money, :message, :deliver_img)
  end
  
  
end
