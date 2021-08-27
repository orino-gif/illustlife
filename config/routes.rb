Rails.application.routes.draw do
  devise_for :users, controllers: {   registrations: 'users/registrations', sessions: 'users/sessions' }
  #get 'home/index'
  resources :home, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index' 
  resources :creators, only: [:new, :create, :index, :show, :edit, :update]
  get 'home/show/:id', to: 'home#show', as: 'home'
  
end
