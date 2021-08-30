Rails.application.routes.draw do
  root to: 'home#index' 
  devise_for :users, controllers: {   registrations: 'users/registrations', sessions: 'users/sessions' }
  resources :home, only: [:index]
  resources :creators, only: [:new, :create, :index, :show, :edit, :update]
  get 'home/show/:id', to: 'home#show', as: 'home'
  
end
