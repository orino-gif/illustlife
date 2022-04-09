Rails.application.routes.draw do

  root to: 'homes#index' 
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks'}
  
  get 'requests/:id/new', to: 'requests#new'
  resources :credits, only: [:new, :create, :show, :update]
  resources :homes, only: [:index]
  resources :creators, only: [:create, :show, :edit, :update]
  resources :requests, only: [:index, :create, :show, :update] do
    member  do
      get 'download'
    end
  end  
    
   resources :explanations, only: [:index, :new, :create] do
    collection  do
      get 'terms'
      get 'policy'
      get 'transaction_law'
    end
  end
end
