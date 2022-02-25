Rails.application.routes.draw do

  root to: 'homes#index' 
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  
  get '/requests/new/:id', to: 'requests#new'
  get '/credits/operation', to: 'credits#operation', as: 'operation'
  get 'explanations/terms'
  get 'explanations/policy'
  get 'explanations/transaction_law'
  
  resources :credits, only: [:new, :create, :show, :update]
  resources :requests, only: [:create, :show, :update, :index]
  resources :homes, only: [:index]
  resources :tests, only: [:index]
  resources :creators, only: [:create, :show, :edit, :update]
  resources :explanations, only: [:index, :new, :create, :show]
end
