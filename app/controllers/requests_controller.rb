class RequestsController < ApplicationController
  #pajpのメソッドを利用可能にする
  require 'payjp' 

  def index
    #ログイン中のユーザーのリクエスト
    @requests = Request.where(receiver_id: current_user.id).or(Request.where(sender_id: current_user.id))
  end
  
  def new
    @request = Request.new
    @creator = Creator.find_by(user_id: params[:id])
  end

  def create
    if (user_signed_in?) && ((nil != Card.find_by(id: current_user.id)) || ('development' == ENV['RAILS_ENV']))
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
        redirect_to request_url(@request.id), notice: 'クリエイターへリクエストメールを送信しました。'
      elsif @request.errors.full_messages[0].include?('too_long')
        redirect_to request.referer, alert: '文字が許容範囲外(1000文字以下)です'
      end
    elsif false == user_signed_in?
      redirect_to  '/users/sign_in', alert: 'ログインが必要です。'
    elsif nil == Card.find_by(id: current_user.id)
      redirect_to request.referer, alert: 'クレジットカード登録が必要です。'
    end
  end

  def show
    @request = Request.find(params[:id])
    #リクエストページのボタンが押された場合の処理
    if not params[:request_id].nil?
      
      #各リクエストIDに対応する情報を収集
      @request = Request.find(params[:request_id])
      @sender = User.find(Request.find(params[:request_id]).sender_id)
      @receiver = User.find(Request.find(params[:request_id]).receiver_id)
      
      #リクエストステータスに対応する処理を実行
      if '拒否' == params[:status]
        UserMailer.refusal_email(@sender, @receiver, @request).deliver_later
        redirect_to request.referer, notice: '依頼者からのリクエストを拒否しました。'
        
      elsif '製作中' == params[:status]
        UserMailer.consent_email(@sender, @receiver, @request).deliver_later
        redirect_to request.referer, notice: '依頼者へ承諾のメールを送信しました。'
        
      elsif '製作中断' == params[:status]
        @request.is_in_time_for_the_deadline = false
        @receiver.creator.number_of_approval -= 1
        @receiver.creator.evaluation_points -= 1
        UserMailer.suspension_email(@sender, @receiver, @request).deliver_later
        redirect_to request.referer, notice: '依頼者へ中断のメールを送信しました。'
        
      elsif '納品完了' == params[:status]
        @card = Card.find_by(id: @sender.id)
        @request.is_in_time_for_the_deadline = true
        @receiver.creator.number_of_works += 1
        @receiver.creator.evaluation_points += 1
        @receiver.creator.earnings += @request.money
        @receiver.creator.withdrawal_amount += @request.money
        # @request.delivery_time =+ 3
        # @receiver.creator.average_delivery_time = 1 + (@requests.all.sum(:delivery_time) / @receiver.creator.number_of_works)
        UserMailer.deliver_email(@sender, @receiver, @request).deliver_later
        redirect_to request.referer, notice: '依頼者への納品完了のメールを送信しました。'
        
        if (nil != @card) && (false == @request.is_reworked)
          Payjp.api_key = ENV['PAYJP_SECRET_KEY']
          Payjp::Charge.create(:amount => params[:amount], :customer => @card.customer_id, :currency => 'jpy')
        end
        
      elsif '手戻し' == params[:status]
        @request.is_reworked = true
        @receiver.creator.number_of_works -= 1
        @receiver.creator.earnings -= @request.money
        @receiver.creator.withdrawal_amount -= @request.money
        UserMailer.rework_email(@sender, @receiver, @request).deliver_later
        redirect_to request.referer, notice: '依頼者への手戻りのメールを送信しました。'
      end

      if 0 != @receiver.creator.number_of_approval
        @receiver.creator.deadline_strict_adherence_rate = 100
      end
      @request.status = params[:status]
      @request.save
      @receiver.creator.save
    end
  end
  
  def download
    hoge = Request.find(params[:id])
    if hoge.deliver_img?
      image = hoge.deliver_img # imageはFugaUploaderオブジェクト
      #extname:text.txtの.移行の文字列を返す
      #send_data(送るデータ, オプション={failname:保存するときに使用するファイル名})
      send_data(image.read, filename: "download#{File.extname(image.path)}")
    else
      redirect_to request.referer, alert: '画像がアップロードされていません'
    end
  end
  
  def update
    @request = Request.find(params[:request][:request_id])
    if 'キャンセル' == params[:request][:cancel]
      @request.deliver_img = 'NULL'
    elsif 'キャンセル2' == params[:request][:cancel]
      @request.deliver_img2 = 'NULL'
    end
    if @request.update(requests_params)
      redirect_to request_path(@request.id)
    else
      p @request.errors.full_messages[0]
      if @request.errors.full_messages[0].include?("extension_whitelist_error")
        redirect_to request.referer, alert: '本サービスのファイル対応形式(png,jpg,jpeg,gif)外です'
      elsif @request.errors.full_messages[0].include?("max_size_error")
        redirect_to request.referer, alert: 'ファイルサイズが本サービスの対応外(1GBより大きい)です'
      else  
        redirect_to request.referer, alert: 'ファイルが選択されていません'
      end
    end
  end
  
  private

  def requests_params
    params.require(:request).permit(:money, :message, :deliver_img, :file_format, :is_nsfw,
      :is_anonymous, :is_autographed, :deliver_img2, :deliver_img3, :deliver_img4, :deliver_img5, :deliver_img6,
      :evaluation_comment)
  end
  
  def creator_params
    params.require(:creator).permit(:number_of_request)
  end
end
