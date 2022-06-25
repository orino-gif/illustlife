class RequestsController < ApplicationController
  require 'payjp' #これでpajpのメソッドが使用できます

  def index
    @requests = Request.where(receiver_id: current_user.id).or(Request.where(sender_id: current_user.id))
    if not params[:request_id].nil?
      @request = Request.find(params[:request_id])
      @sender = User.find(nickname: Request.find(params[:request_id]).sender_id)
      @receiver = User.find(nickname: Request.find(params[:request_id]).receiver_id)

      if '拒否' == params[:status] || (@request.created_at + 60*60*24*14) < Time.now
        UserMailer.refusal_email(@sender, @receiver, @request).deliver_later
        redirect_to request.referer, notice: '依頼者からのリクエストを拒否しました。'
        
      elsif '製作中' == params[:status]
        @receiver.creator.number_of_approval += 1
        @request.approval_day = Time.now
        UserMailer.consent_email(@sender, @receiver, @request).deliver_later
        redirect_to request.referer, notice: '依頼者へ承諾のメールを送信しました。'
        
      elsif '製作中断' == params[:status]
        @request.is_in_time_for_the_deadline = false
        @receiver.creator.number_of_approval -= 1
        @receiver.creator.evaluation_points -= 10
        UserMailer.suspension_email(@sender, @receiver, @request).deliver_later
        redirect_to request.referer, notice: '依頼者へ中断のメールを送信しました。'
        
      elsif '納品完了' == params[:status]
        @card = Card.find_by(user_id: @sender.id)
        @request.is_in_time_for_the_deadline = true
        @receiver.creator.number_of_works += 1
        @receiver.creator.evaluation_points += 3
        p @requests.all.sum(:delivery_time)
        p Time.now - @request.approval_day
        @request.delivery_time =+ 1
        @receiver.creator.average_delivery_time = 1 + (@requests.all.sum(:delivery_time) / @receiver.creator.number_of_works)
        UserMailer.deliver_email(@sender, @receiver, @request).deliver_later
        redirect_to request.referer, notice: '依頼者への納品完了のメールを送信しました。'
        
        if not @card.nil?
          Payjp.api_key = ENV['PAYJP_SECRET_KEY']
          Payjp::Charge.create(:amount => params[:amount], :customer => @card.customer_id, :currency => 'jpy')
        end
        
      elsif '手戻し' == params[:status]
        @receiver.creator.number_of_works -= 1
        UserMailer.rework_email(@sender, @receiver, @request).deliver_later
        redirect_to request.referer, notice: '依頼者への手戻りのメールを送信しました。'
      end
      
      p @requests.all.sum(:is_in_time_for_the_deadline)
      
      @receiver.creator.deadline_strict_adherence_rate = 100-(@requests.all.sum(:is_in_time_for_the_deadline) / @receiver.creator.number_of_approval)
      @request.status = params[:status]
      @request.save
      @receiver.creator.save
    end
  end
  
  def new
    @request = Request.new
    @authorizer = User.find(params[:id])
  end

  def create
    if user_signed_in?
      @sender = current_user
      @receiver = User.find(params[:authorizer_id])
      @card = Card.find_by(user_id: current_user.id)
      
      @request = Request.new(requests_params)
      @request.sender = @sender.id
      @request.receiver = @receiver.id
      @request.status = '承認待ち'
      @request.sender_icon_url = @sender.creator.icon
      @request.receiver_icon_url = @receiver.creator.icon
      
      if ((nil != @card) || ('development' == ENV['RAILS_ENV'])) && (@request.save)
        current_user.creator.number_of_request += 1
        current_user.creator.save
        UserMailer.request_email(@sender, @receiver, @request).deliver_later
        redirect_to requests_url, notice: 'クリエイターへリクエストメールを送信しました。'
      elsif @card.nil?
        redirect_to request.referer, alert: '事前にクレジットカードの登録が必要です'
      elsif false == @request.save
        redirect_to request.referer, alert: '文字(1000文字以下)が許容範囲外です'
      end
    else
      redirect_to  '/users/sign_in', alert: 'ユーザー登録とログインが必要です。'
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
      redirect_to requests_path(@requests, anchor: 'page1')
    else
      redirect_to request.referer, alert: 'ファイル形式かサイズ(2GB以下)が非対応です'
    end
  end
  
  private

  def requests_params
    params.require(:request).permit(:money, :message, :deliver_img, :file_format, :sender_icon_url, :receiver_icon_url,
    :is_nsfw, :is_anonymous, :is_autographed)
  end
  
  def creator_params
    params.require(:creator).permit(:number_of_request)
  end
end
