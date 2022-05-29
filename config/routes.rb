Rails.application.routes.draw do

  get 'products/index'
  post 'products/pay'
  root to: 'homes#index' 
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks'}
  # 退会確認画面
  get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
  # 論理削除用のルーティング
  patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
  
  get 'requests/:id/new', to: 'requests#new'
  resources :credits, only: [:new, :create, :show, :update]
  resources :homes, only: [:index]
  resources :creators, only: [:create, :show, :edit, :update]
  resources :requests, only: [:index, :create, :show, :update] do
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
    end
  end
end
