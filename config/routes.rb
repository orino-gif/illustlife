Rails.application.routes.draw do
  
  root to: 'home#index' 
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  resources :home, only: [:index]
  resources :tests, only: [:index]
  resources :creators, only: [:create, :show, :edit, :update]
  get '/requests/new/:id', to: 'requests#new'
  resources :requests, only: [:create, :show, :update, :index]
  get '/credits/operation', to: 'credits#operation', as: 'operation'
  resources :credits, only: [:new, :create, :show, :update]
  get 'explanations/terms'
  get 'explanations/policy'
  get 'explanations/transaction_law'
  resources :explanations, only: [:index, :new, :create, :show]
  
  resources :cards,  only: [:new, :create, :destroy] do
    collection do
      get "show_card"
    end
  end
end
