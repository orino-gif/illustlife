Rails.application.routes.draw do
  root to: 'home#index' 
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  resources :home, only: [:index]
  resources :creators, only: [:create, :show, :edit, :update]
end
