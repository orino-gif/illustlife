class CardsController < ApplicationController
  # before_action :card_present, only:[:pay_charge]
  
  require 'payjp' #これでpajpのメソッドが使用できます
  
  # cardsのログインユーザーのレコードを取得
  def new 
    gon.public_key = ENV['PAYJP_PRIVATE_KEY']

    @card = Card.where(id: current_user.id)
    redirect_to action: "show" if @card.exists?
  end
  
  # cardsのログインユーザーのレコードをpayjpに送りカード情報を取り出す
  def show 
    card = Card.find_by(id: current_user.id)
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
    @card = Card.find_by(id: current_user.id)
    if @card.blank?
      # Nothing
    else
      begin
        Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
        customer = Payjp::Customer.retrieve(@card.customer_id)
        customer.delete
        Card.find(current_user.id).delete
        redirect_to action: "new"
        
      rescue Payjp::PayjpError => e
        p "クレジットカード削除が失敗されました:" + e.to_s
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
      customer = Payjp::Customer.create(
      card: params['payjp_token'],
      # description: '登録テスト', #なくてもOK
      # email: current_user.email, #なくてもOK
      # metadata: {id: current_user.id}
      ) #念の為metadataにuser_idを入れましたがなくてもOK
      
      # カードテーブルのデータの作成
      @card = Card.new(
        id: current_user.id,
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
  
  # def pay_charge
  #   Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
  #   Payjp::Charge.create(
  #   :amount => params[:amount],
  #   :customer => @card.customer_id,
  #   :currency => 'jpy'
  # )
  # end
  
  # private
  
  # def card_present
  #   @card = Card.where(id: current_user.id).first if Card.where(id: current_user.id).present?
  # end
end