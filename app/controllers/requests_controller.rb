class RequestsController < ApplicationController
  
  # pajpのメソッドを利用可能にする
  require 'payjp'

  def index
    # ログインユーザーに関係するレコード達を@reqsに格納
    @reqs = Request.where(rx_id: current_user.id)
    .or(Request.where(tx_id: current_user.id))
  end
  
  def new
    # リクエストのレコード作成と、クリエーター情報を表示する
    @req = Request.new
    @creator = Creator.find_by(user_id: params[:id])
  end

  def create
    # ログイン状態で、カード登録済みか開発環境の場合、リクエスト処理を実行
    if user_signed_in?
      if Card.find_by(user_id: current_user.id) || \
        ('development' == ENV['RAILS_ENV'])
        @tx = current_user
        @rx = User.find(params[:authorizer_id])
        @req = Request.new(requests_params)
        @req.tx_id = @tx.id
        @req.rx_id = @rx.id
        @req.stts = '承認待ち'
        if @req.save
          Work.create(request_id:@req.id)
          UserMailer.req(@tx, @rx).deliver_later
          redirect_to requests_url, notice: 'リクエストを送信しました。'
            
        elsif @req.errors.full_messages[0].include?('too_long')
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
      @req = Request.find(params[:id])
      @work = Work.find_by(request_id:params[:id])
      
    elsif params[:request_id]
      # リクエストIDに対応する依頼者と承認者のインスタンスの生成
      @req = Request.find(params[:request_id])
      @tx = User.find(@req.tx_id)
      @rx = User.find(@req.rx_id)
      # @rx_p = Performance.find_by(creator_id:@req.rx_id)
      @work = Work.new(request_id: @req.id)
      # リクエストステータスに対応する処理を実行
      if '拒否' == params[:stts]
        UserMailer.refusal(@tx, @rx).deliver_later
         redirect_to request.referer, notice: 'リクエストを拒否しました'

      elsif '製作中' == params[:stts]
        if @card = Card.find_by(user_id: @tx.id)
          Payjp.api_key = ENV['PAYJP_SECRET_KEY']
          begin
            Payjp::Charge.create(:amount => params[:amount],
            :customer => @card.cus_id, :currency => 'jpy')
          rescue Payjp::PayjpError => e
            @req.stts = '購入者キャンセル'
            # 承認者へ決済不備によるキャンセルを知らせる
            UserMailer.declined(@tx, @rx, @req).deliver_later
            p "例外エラー:" + e.to_s
            redirect_to request.referer,
            alert: '購入者側の決済の問題でキャンセルとなりました'
          end
          UserMailer.consent(@tx, @rx).deliver_later
          redirect_to request.referer,
          notice: '依頼者へ承諾のメールを送信しました'
        else
          @req.stts = '購入者キャンセル'
          redirect_to request.referer,
          alert: '購入者側のクレジットが未登録の為、キャンセルとなりました'
        end
        
      elsif '製作中断' == params[:stts]
        @rx.creator.performance.eval -= 20
        UserMailer.quit(@tx, @rx).deliver_later
        redirect_to request.referer,
          notice: '依頼者へ作業中断のメールを送信しました'
      elsif '納品完了' == params[:stts]
        if false == @req.work.rework
          @rx.creator.performance.pic += 1
          @rx.creator.performance.eval += 10
          @rx.creator.performance.sales += @req.money
          @rx.creator.performance.wdl += @req.money
          @req.work.d_time = Time.now
        end
        
        UserMailer.del(@tx, @rx).deliver_later
        redirect_to request.referer,
        notice: '依頼者への納品完了のメールを送信しました'

      elsif '手戻し' == params[:stts]
        @req.work.rework = true
        @req.work.in_time = false
        
        UserMailer.rework(@tx, @rx).deliver_later
        redirect_to request.referer,
        notice: '依頼者への手戻りのメールを送信しました'
      end

      @rx.creator.performance.dl = 100
      if @req.stts != '購入者キャンセル'
        @req.stts = params[:stts]
      end
      @req.save
      @req.work.save
      @rx.creator.save
      @rx.creator.performance.save
    end
  end
  
  def download
    @work = Work.find_by(request_id: params[:request_id])
    if @req.work.img1?
      image = @req.work.img1 # imageはUploaderオブジェクト
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
      @req.work.img1 = 'NULL'
      
    elsif 'キャンセル2' == params[:request][:cancel]
      @req.work.img2 = 'NULL'
      
    elsif 'キャンセル3' == params[:request][:cancel]
      @req.work.img3 = 'NULL'
      
    elsif 'キャンセル4' == params[:request][:cancel]
      @req.work.img4 = 'NULL'
      
    elsif 'キャンセル5' == params[:request][:cancel]
      @req.work.img5 = 'NULL'
      
    elsif 'キャンセル6' == params[:request][:cancel]
      @req.work.img6 = 'NULL'
    end
    
    if @req.update(requests_params)
      redirect_to request_path(@req.id)
    else
      p @req.errors.full_messages[0]
      if @req.errors.full_messages[0].include?("extension_whitelist_error")
        flash.now[:alert] = 'ファイル対応形式(png,jpg,jpeg,gif)外です。'
        render :show

      elsif @req.errors.full_messages[0].include?("max_size_error")
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
