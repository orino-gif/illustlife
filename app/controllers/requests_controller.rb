class RequestsController < ApplicationController
  require 'payjp' #これでpajpのメソッドが使用できます

  def index
    @requests = Request.where(receiver_id: current_user.id).or(Request.where(sender_id: current_user.id))
    if not params[:request_id].nil?
      @request = Request.find(params[:request_id])
      @sender = User.find(Request.find(params[:request_id]).sender_id)
      @receiver = User.find(Request.find(params[:request_id]).receiver_id)

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
        @receiver.creator.earnings += @request.money
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
      p @receiver.creator.number_of_approval
      
      if 0 != @receiver.creator.number_of_approval
        @receiver.creator.deadline_strict_adherence_rate = 100-(@requests.all.sum(:is_in_time_for_the_deadline) / @receiver.creator.number_of_approval)
      end
      @request.status = params[:status]
      @request.save
      @receiver.creator.save
    end
  end
  
  def new
    @request = Request.new
    @creator = Creator.find_by(user_id: params[:id])
  end

  def create
    @card = Card.find_by(user_id: current_user.id)
    if (user_signed_in?) && ((nil != @card) || ('development' == ENV['RAILS_ENV']))
      @sender = current_user
      @receiver = User.find(params[:authorizer_id])
      
      @request = Request.new(requests_params)
      @request.sender_id = @sender.id
      @request.receiver_id = @receiver.id
      @request.status = '承認待ち'

      if @request.save
        current_user.creator.number_of_request += 1
        current_user.creator.save
        UserMailer.request_email(@sender, @receiver, @request).deliver_later
        redirect_to requests_url, notice: 'クリエイターへリクエストメールを送信しました。'
      elsif @request.errors.full_messages[0].include?('too_long')
        redirect_to request.referer, alert: '文字が許容範囲外(1000文字以下)です'
      end
    elsif false == user_signed_in?
      redirect_to  '/users/sign_in', alert: 'ユーザー登録とログインが必要です。'
    elsif nil == @card
      redirect_to request.referer, alert: 'クレジットカード登録が必要です。'
    end
  end

  def show
    @request = Request.find(params[:id])
  end
  
  def download
    hoge = Request.find(params[:id])
    if hoge.deliver_img?
      image = hoge.deliver_img # imageはFugaUploaderオブジェクト
      send_data(image.read, filename: "download#{File.extname(image.path)}")
    else
      redirect_to request.referer, alert: '画像がアップロードされていません'
    end
  end
  
  def update
    @requests = Request.find(params[:request][:request_id])
    if @requests.update(requests_params)
      redirect_to requests_path(@requests, anchor: 'page1')
    else
      p @requests.errors.full_messages[0]
      if @requests.errors.full_messages[0].include?("extension_whitelist_error")
        redirect_to request.referer, alert: '本サービスのファイル対応形式(png,jpg,jpeg,gif)外です'
      elsif @requests.errors.full_messages[0].include?("max_size_error")
        redirect_to request.referer, alert: 'ファイルサイズが本サービスの対応外(1GBより大きい)です'
      else  
        redirect_to request.referer, alert: 'ファイルが選択されていません'
      end
    end
  end
  
  private

  def requests_params
    params.require(:request).permit(:money, :message, :deliver_img, :file_format, :is_nsfw,
      :is_anonymous, :is_autographed)
  end
  
  def creator_params
    params.require(:creator).permit(:number_of_request)
  end
end
