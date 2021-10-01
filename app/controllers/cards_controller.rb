class CardsController < ApplicationController
  def new
    if Card.find_by(user_id: current_user.id) == nil
      @card = Card.new
    else
      redirect_to show_card_cards_path
    end
  end
  
  def create
    #Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    
    
    
    Payjp.api_key = "sk_test_3807d7ff01e24b45310ebb5a"
    token = Payjp::Token.create({
      card: {
        number:     params[:card][:number],
        cvc:        params[:card][:cvc],
        exp_month:  params[:card][:exp_month],
        exp_year:   "20#{params[:card][:exp_year]}".to_i
      }},
      {'X-Payjp-Direct-Token-Generate': 'true'} 
    )
    if token.blank?
      redirect_to new_card_path
    else
      customer = Payjp::Customer.create(card: token)
      card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if card.save
        redirect_to show_card_cards_path
      else
        redirect_to new_card_path
      end
    end
  end
  
 def show_card
  card = Card.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to :new
    else
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer = Payjp::Customer.retrieve(card.customer_id)
    @default_card_information = Payjp::Customer.retrieve(card.customer_id).cards.data[0]
    end
  end
  
   def destroy
    if Card.find_by(user_id: current_user.id).destroy
      redirect_to root_path
    else
      render :show_card
    end
  end
    
    
end
