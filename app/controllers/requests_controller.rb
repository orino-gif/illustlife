class RequestsController < ApplicationController
  
  # pajpのメソッドを利用可能にする
  require 'payjp'

  def index
    # ログインユーザーに関係するレコード達を@requestsに格納
    @requests = Request.where(rx_id: current_user.id)
      .or(Request.where(tx_id: current_user.id))
  end
  
  def new
    # リクエストのレコード作成と、クリエーター情報を表示する
    @request = Request.new
    @creator = Creator.find_by(user_id: params[:id])
  end

  def create
    # ログイン状態で、カード登録済みか開発環境の場合、リクエスト処理を実行
    if user_signed_in?
      if Card.find_by(user_id: current_user.id) || \
        ('development' == ENV['RAILS_ENV'])
        @sender = current_user
        @receiver = User.find(params[:authorizer_id])
        @request = Request.new(requests_params)
        @request.tx_id = @sender.id
        @request.rx_id = @receiver.id
        @request.stts = '承認待ち'
        if @request.save
          Work.create(request_id:@request.id)
          UserMailer.req(@sender, @receiver).deliver_later
          redirect_to requests_url, notice: 'リクエストを送信しました。'
            
        elsif @request.errors.full_messages[0].include?('too_long')
          flash.now[:alert] = '文字が許容範囲外(700文字より大きい)です'
          render :new
        else
          flash.now[:alert] = 'リクエスト送信に失敗しました'
          render :new
        end
      end
      
    elsif (not user_signed_in?)
      redirect_to  '/users/sign_in', alert: 'ログインが必要です。'
      
    elsif Card.find_by(user_id: current_user.id).nil?
      flash.now[:alert] = "クレジットカード登録が必要です。" 
      render :new
    end
  end

  def show
    # リクエスト詳細ページのボタンが押された場合の処理
    if params[:request_id].nil?
      @request = Request.find(params[:id])
      @work = Work.find_by(request_id:params[:id])
      
    elsif params[:request_id]
      # リクエストIDに対応する依頼者と承認者のインスタンスの生成
      @request = Request.find(params[:request_id])
      @sender = User.find(@request.tx_id)
      @receiver = User.find(@request.rx_id)
      # @receiver_p = Performance.find_by(creator_id:@request.rx_id)
      @work = Work.new(request_id: @request.id)
      # リクエストステータスに対応する処理を実行
      if '拒否' == params[:stts]
        UserMailer.refusal(@sender, @receiver).deliver_later
         redirect_to request.referer, notice: 'リクエストを拒否しました'

      elsif '製作中' == params[:stts]
        if @card = Card.find_by(user_id: @sender.id)
          Payjp.api_key = ENV['PAYJP_SECRET_KEY']
          begin
            Payjp::Charge.create(:amount => params[:amount],
            :customer => @card.customer_id, :currency => 'jpy')
          rescue Payjp::PayjpError => e
            @request.stts = '購入者キャンセル'
            # 承認者へ決済不備によるキャンセルを知らせる
            UserMailer.declined(@sender, @receiver, @request).deliver_later
            p "例外エラー:" + e.to_s
            redirect_to request.referer,
            alert: '購入者側の決済の問題でキャンセルとなりました'
          end
          UserMailer.consent(@sender, @receiver).deliver_later
          redirect_to request.referer,
          notice: '依頼者へ承諾のメールを送信しました'
        else
          @request.stts = '購入者キャンセル'
          redirect_to request.referer,
          alert: '購入者側のクレジットが未登録の為、キャンセルとなりました'
        end
        
      elsif '製作中断' == params[:stts]
        @receiver.creator.performance.evaluation -= 20
        UserMailer.quit(@sender, @receiver).deliver_later
        redirect_to request.referer,
          notice: '依頼者へ作業中断のメールを送信しました'
      elsif '納品完了' == params[:stts]
        if false == @request.work.rework
          @receiver.creator.performance.painting += 1
          @receiver.creator.performance.evaluation += 10
          @receiver.creator.performance.earnings += @request.money
          @receiver.creator.performance.withdrawal += @request.money
          @request.work.d_time = Time.now
        end
        
        UserMailer.del(@sender, @receiver).deliver_later
        redirect_to request.referer,
        notice: '依頼者への納品完了のメールを送信しました'

      elsif '手戻し' == params[:stts]
        @request.work.rework = true
        @request.work.in_time = false
        
        UserMailer.rework(@sender, @receiver).deliver_later
        redirect_to request.referer,
        notice: '依頼者への手戻りのメールを送信しました'
      end

      @receiver.creator.performance.deadline = 100
      if @request.stts != '購入者キャンセル'
        @request.stts = params[:stts]
      end
      @request.save
      @request.work.save
      @receiver.creator.save
      @receiver.creator.performance.save
    end
  end
  
  def download
    @work = Work.find_by(request_id: params[:request_id])
    if @request.work.img1?
      image = @request.work.img1 # imageはUploaderオブジェクト
      # extnameは「.」以降の拡張子にあたる文字列を返す
      # send_data(送るデータ, オプション={failname:保存するときのファイル名})
      send_data(image.read, filename: "download#{File.extname(image.path)}")
    else
      flash.now[:alert] = '画像がアップロードされていません。'
      render :show
    end
  end
  
  def update
    @work = Work.find_by(params[:request][:request_id])
    if 'キャンセル' == params[:request][:cancel]
      @request.work.img1 = 'NULL'
      
    elsif 'キャンセル2' == params[:request][:cancel]
      @request.work.img2 = 'NULL'
      
    elsif 'キャンセル3' == params[:request][:cancel]
      @request.work.img3 = 'NULL'
      
    elsif 'キャンセル4' == params[:request][:cancel]
      @request.work.img4 = 'NULL'
      
    elsif 'キャンセル5' == params[:request][:cancel]
      @request.work.img5 = 'NULL'
      
    elsif 'キャンセル6' == params[:request][:cancel]
      @request.work.img6 = 'NULL'
    end
    
    if @request.update(requests_params)
      redirect_to request_path(@request.id)
    else
      p @request.errors.full_messages[0]
      if @request.errors.full_messages[0].include?("extension_whitelist_error")
        flash.now[:alert] = 'ファイル対応形式(png,jpg,jpeg,gif)外です。'
        render :show

      elsif @request.errors.full_messages[0].include?("max_size_error")
        flash.now[:alert] = 'ファイルサイズが対応外(1GBより大きい)です'
        render :show

      else
        flash.now[:alert] = 'ファイルが選択されていません'
        render :show
      end
    end
  end
  
  private

  def requests_params
    params.require(:request).permit(:money,:stts,:fmt,:nsfw,:anon,:auto)
  end
  
  def creator_params
    params.require(:creator).permit(:number_of_request,:temp_img)
  end
end
