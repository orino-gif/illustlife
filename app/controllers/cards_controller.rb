class CardsController < ApplicationController
  # def new
  #   if Card.find_by(user_id: current_user.id) == nil
  #     @card = Card.new
  #   else
  #     redirect_to show_card_cards_path
  #   end
  # end
  
  # def create
  #   Payjp.api_key = Rails.application.credentials.payjp[:secret_key] # ここで秘密鍵をセット！！
  #   token = Payjp::Token.create({
  #     card: {
  #       number:     params[:card][:number],
  #       cvc:        params[:card][:cvc],
  #       exp_month:  params[:card][:exp_month],
  #       exp_year:   "20#{params[:card][:exp_year]}".to_i
  #     }},
  #     {'X-Payjp-Direct-Token-Generate': 'true'} 
  #   )
  #   if token.blank?
  #     redirect_to new_card_path
  #   else
  #     customer = Payjp::Customer.create(card: token)
  #     card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
  #     if card.save
  #       redirect_to show_card_cards_path
  #     else
  #       redirect_to new_card_path
  #     end
  #   end
  # end
  
  # def show_card
  # card = Card.find_by(user_id: current_user.id)
  #   if card.blank?
  #     redirect_to :new
  #   else
  #     Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
  #     customer = Payjp::Customer.retrieve(card.customer_id)
  #     @default_card_information = Payjp::Customer.retrieve(card.customer_id).cards.data[0]
  #   end
  # end
  
  # def destroy
  #   if Card.find_by(user_id: current_user.id).destroy
  #     redirect_to new_card_path
  #   else
  #     render :show_card
  #   end
  # end
    
  require 'payjp'

  before_action :set_item, only:[:show,:pay]
  before_action :take_card, only:[:show,:pay]
  before_action :set_api_key

  def show 
      if @card.blank?
        #登録された情報がない場合にカード登録画面に移動
        flash[:alert] = '購入前にカード登録してください'
        redirect_to cards_path and return
      else
        #保管した顧客IDでpayjpから情報取得
        set_customer
        #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
        set_card_information
      end
      if current_user.address == nil
          flash[:alert] = '購入前に住所登録してください'
          redirect_to new_address_path
      end
  end

private

  def set_item
    @item = Item.find(params[:id])
    @address = Address.find_by(user_id:current_user.id)
  end

  def set_api_key
    Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_PRIVATE_KEY]
    #binding.pry
  end

  def set_customer
    @customer = Payjp::Customer.retrieve(@card.customer_id)
  end

  def set_card_information
    @card_information = @customer.cards.retrieve(@card.card_id)
  end

  def take_card
    @card = Card.find_by(user_id: current_user.id)
  end

end