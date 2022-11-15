class CardsController < ApplicationController
  require 'payjp' #これでpajpのメソッドが使用できます
  # cardsのログインユーザーのレコードを取得
  def new 
    gon.public_key = ENV['PAYJP_PRIVATE_KEY']
    @card = Card.where(user_id: current_user.id)
    redirect_to action: "show" if @card.exists?
  end
  # cardsのログインユーザーのレコードをpayjpに送りカード情報を取り出す
  def show 
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      render :new
    else
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      begin
        customer = Payjp::Customer.retrieve(card.customer_id)
        @default_card_information = customer.cards.retrieve(card.card_id)
      rescue Payjp::PayjpError => e
        if Rails.env.development?
          p "例外エラー:" + e.to_s
          flash[:alert] = "payjpの顧客情報が消えて、\
            稼働元のデータベースに顧客情報が残っている状態が起こりました" 
          render :new
        end
      end
    end
  end
  # ログインユーザーのクレジットカード登録情報を削除する
  def delete 
    @card = Card.find_by(user_id: current_user.id)
    if not @card.blank?
      begin
        Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
        customer = Payjp::Customer.retrieve(@card.customer_id)
        customer.delete
        Card.find_by(user_id: current_user.id).delete
        redirect_to action: "new"
      rescue Payjp::PayjpError => e
        p "クレジットカード削除に失敗しました:" + e.to_s
        p "稼働元のレコードが削除されませんでした"
        flash.now[:alert] = "クレジットカードの削除に失敗しました" 
        render :show
      end
    end
  end
  # カードの登録ボタンが押された時の処理。payjpとcardsにレコードを追加する。
  def pay
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    if params['payjp_token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(card: params['payjp_token']) 
      # カードテーブルのデータの作成
      @card = Card.new(
        user_id: current_user.id,
        customer_id: customer.id,
        card_id: customer.default_card
      )
      if @card.save
        redirect_to action: "show", notice: "クレジットカードが登録されました"
      else
        flash.now[:alert] = "クレジットカードの登録に失敗しました" 
        render :new
      end
    end
  end
end