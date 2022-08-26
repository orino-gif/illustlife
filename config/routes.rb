Rails.application.routes.draw do

  get 'products/index'
  post 'products/pay'
  root to: 'homes#index' 
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks'}

  get 'requests/:id/new', to: 'requests#new'
  get 'credits/:id/new', to: 'credits#new'
  get 'resumes/:id/new', to: 'resumes#new'
  get 'creators/:id/earning', to: 'creators#earning'
  resources :resumes, only: [:index, :create, :show, :destroy]
  resources :mangas, only: [:index, :show]  do
    resources :illustlifes, only: [:index, :show]
  end
  resources :credits, only: [:create, :show, :update]
  resources :homes, only: [:index] do
    resources :manuals, only: [:index, :show]
  end
  resources :creators, only: [:show, :edit, :update]
  resources :requests do
    member  do
      get 'download'
    end
  end  
  resources :cards, only: [:index, :new, :create, :show, :pay_charge] do
    collection do
      get 'index', to: 'cards#index'
      post 'pay_charge', to: 'cards#pay_charge'
      post 'show', to: 'cards#show'
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
    end
  end
  resources :explanations, only: [:index, :new, :create] do
    collection  do
      get 'terms'
      get 'policy'
      get 'transaction_law'
      get 'for_client'
    end
  end
end
