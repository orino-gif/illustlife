class CardsController < ApplicationController
  
  require 'payjp' #これでpajpのメソッドが使用できます
  
  before_action :card_present, only:[:pay_charge]
  
  def new
    card = Card.where(user_id: current_user.id)
    p 'bbb'
    redirect_to action: "show" if card.exists?
  end
  
  def pay#payjpとCardのデータベース作成
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    if params['payjp_token'].blank?
      redirect_to action: "new"
    else
      p params['payjp_token']
      customer = Payjp::Customer.create(
      description: '登録テスト', #なくてもOK
      email: current_user.email, #なくてもOK
      card: params['payjp_token'],
      metadata: {user_id: current_user.id}
      ) #念の為metadataにuser_idを入れましたがなくてもOK
      @card = Card.new(                  # カードテーブルのデータの作成
        user_id: current_user.id,        # ここでcurrent_user.idがいるので、前もってsigninさせておく
        customer_id: customer.id,        # customerは上で定義
        card_id: customer.default_card  # .default_cardを使うことで、customer定義時に紐付けされたカード情報を引っ張ってくる ここがnullなら上のcustomerのcard: params['payjp_token']が読み込めていないことが多い
      )
      if @card.save
        redirect_to action: "show", notice: "クレジットカードが登録されました"
      else
        redirect_to action: "pay", notice: "クレジットカードの登録に失敗しました"
      end
    end
  end
  
  def pay_charge
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
    :amount => params[:amount],
    :customer => @card.customer_id,
    :currency => 'jpy'
  )
  end
  
  def show #Cardのデータpayjpに送り情報を取り出します
    card = Card.find_by(user_id: current_user.id)
    p card
    if card.blank?
      p 'aaa'
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      p Payjp.api_key
      p card.customer_id
      customer = Payjp::Customer.retrieve(card.customer_id)
      p card.card_id
      @default_card_information = customer.cards.retrieve(card.card_id)
      p @default_card_information
    end
  end

  def delete
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
    else
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
    redirect_to action: "new"
  end
  
  private
  
  def card_present
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end
end