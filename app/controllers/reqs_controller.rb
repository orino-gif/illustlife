class ReqsController < ApplicationController
  require 'payjp'
  def index
    # ログインユーザー関係レコードを@reqsに格納
    @reqs = Req.where(rx_id: current_user.id)
    .or(Req.where(tx_id: current_user.id))
  end
  
  def new
    # レコード作成とクリエーター情報表示を行う
    @req = Req.new; @cre = Cre.find_by(user_id: params[:id])
  end

  def create
    # カード登録済みの場合にリクエスト処理を実行
    if user_signed_in?
      card = Card.find_by(user_id: current_user.id)
      if card || ('development' == ENV['RAILS_ENV'])
        @tx=current_user; @rx=User.find(params[:tx_id])
        @req = Req.new(reqs_params)
        @req.tx_id=@tx.id; @req.rx_id=@rx.id; @req.stts='承認待ち'
        if @req.save
          Work.create(req_id:@req.id)
          UserMailer.req(@tx, @rx).deliver_later
          redirect_to reqs_url, notice: 'リクエストを送信しました。'
        elsif @req.errors.full_messages[0].include?('too_long')
          flash.now[:alert] = '文字範囲外(700文字より大きい)です'; render :new
        else
          flash.now[:alert] = 'リクエスト送信に失敗しました'; render :new
        end
      else
        flash.now[:alert] = "クレジットカード登録が必要です。"; render :new
      end
    else
      redirect_to  '/users/sign_in', alert: 'ログインが必要です。'
    end
  end
  
  def update
    if @req.update(reqs_params)
      redirect_to req_path(@req.id)
    else
      p @req.errors.full_messages[0]
      if @req.errors.full_messages[0].include?("extension_whitelist_error")
        flash.now[:alert] = 'ファイル形式が対応外です。'; render :show
      elsif @req.errors.full_messages[0].include?("max_size_error")
        flash.now[:alert] = 'ファイルサイズが対応(1GB)外です'; render :show
      else
        flash.now[:alert] = 'ファイルが選択されていません'; render :show
      end
    end
  end
  
  private
  def reqs_params
    params.require(:req).permit(:money,:stts,:msg,:fmt,:nsfw,:anon,:auto)
  end
end