class RequestsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  
  def index
    @request = Request.find_by(sender: current_user.nickname)
    if nil == @request
      @request = Request.find_by(receiver: current_user.nickname)
    end
    
    @requests = Request.where(receiver: current_user.nickname).or(Request.where(sender: current_user.nickname))
    @sender = User.find_by(nickname: @request.sender)
    @receiver = User.find_by(nickname: @request.receiver)

    if 'ON' == params[:pressed] 
      @request = Request.find(params[:request_id])
      @request.status = params[:status]
      if @request.save
        if '拒否' == params[:status]
          UserMailer.refusal_email(@sender, @receiver, @request).deliver_later
          @receiver.creator.number_of_rejection = @receiver.creator.number_of_rejection + 1
          redirect_to requests_url, notice: '依頼者からのリクエストを拒否するメールを送信しました。'
          
        elsif '製作中' == params[:status]
          UserMailer.consent_email(@sender, @receiver, @request).deliver_later
          @receiver.creator.number_of_rejection = @receiver.creator.number_of_rejection + 1
          redirect_to requests_url, notice: '依頼者へ承諾のメールを送信しました。'
          
        elsif '納品完了' == params[:status]
          @receiver.creator.number_of_works = @receiver.creator.number_of_works + 1
          UserMailer.deliver_email(@sender, @receiver, @request).deliver_later
          redirect_to requests_url, notice: '依頼者への納品完了のメールを送信しました。'
          
        elsif '手戻し' == params[:status]
          @receiver.creator.number_of_works = @receiver.creator.number_of_works - 1
          UserMailer.rework_email(@sender, @receiver, @request).deliver_later
          redirect_to requests_url, notice: '依頼者への手戻りのメールを送信しました。'
        end
        @receiver.creator.save
      end
    end
  end
  
  def new
    @requests = Request.new
    $receive_id = params[:id]
    p $receive_id 
    @user = User.find(params[:id])
  end
  
  def create
    if (user_signed_in?) && ($receiver_id != current_user.id)
      @requests = Request.new(requests_params)
      @sender = current_user
      @receiver = User.find($receive_id.to_i)
      @requests.sender = @sender.nickname
      @requests.receiver = @receiver.nickname
      @requests.status = '承認待ち'
      
      if @requests.save
        current_user.creator.number_of_request = current_user.creator.number_of_request + 1
        current_user.creator.save
        UserMailer.request_email(@sender,@receiver,@requests).deliver_later
        redirect_to requests_url, notice: 'クリエイターへリクエストメールを送信しました。'
      else
        render :new
      end
    elsif $receiver_id == current_user.id
      redirect_to  request.referer, notice: 'ご自身へのリクエストはできません。'
    else
      redirect_to  '/users/sign_in', notice: 'ユーザー登録とログインが必要です。'
    end
  end

  def show
    @request = Request.find(params[:id])
  end
  
  def download
    hoge = Request.find(params[:id])
    image = hoge.deliver_img # imageはFugaUploaderオブジェクト
    send_data(image.read, filename: "download#{File.extname(image.path)}")
  end
  
  def update
    @requests = Request.find(params[:request][:request_id])
    if @requests.update(requests_params)
      redirect_to requests_url, notice: '問題がなければ納品ボタンを押してください。'
    else
      render :new
    end
    
  end
  
  private

  def requests_params
    params.require(:request).permit(:money, :message, :deliver_img, :file_format)
  end
  
  def creator_params
    params.require(:creator).permit(:number_of_request)
  end
end
