Rails.application.routes.draw do
  devise_for :users, controllers: {   registrations: 'users/registrations', sessions: 'users/sessions' }
  #get 'home/index'
  resources :home, only: [:index]
  get 'user/show/:id', to: 'user#show', as: 'profile'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index' 
  resources :creators, only: [:new, :create, :index, :show, :edit]
  get 'home/show/:id', to: 'home#show', as: 'home'
  
end
