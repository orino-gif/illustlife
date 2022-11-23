Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations',
  sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks'}
  root to: 'homes#index'
  resource :agreement, only: [:index] do
    collection do
      get 'terms'
      get 'policy'
      get 'transaction_law'
    end
  end
  resources :cards, only: [:new, :show] do
    collection do
      post 'show', to: 'cards#show'
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
    end
  end
  resources :cres, only: [:show, :edit, :update] do
    collection do
      get '/:id/earning', to: 'creators#earning'
    end
  end
  resources :crs, only: [:show, :update] do
    collection do
      get '/:id/new', to: 'credits#new'
    end
  end
  resources :expls, only: [:index, :new, :create]
  resources :exprs, only: [:index, :create, :show] do
    collection do
      get '/:id/new', to: 'expsrs#new'
    end
    resources :contributors, only: [:index, :show]
  end
  resources :homes, only: [:index] do
    resources :manuals, only: [:index, :show]
  end
  resources :mangas, only: [:index, :show]  do
    resources :illustlifes, only: [:index, :show]
  end
  resources :reqs, only: [:index, :create, :show, :update] do
    collection do
      get '/:id/new', to: 'requests#new'
    end
  end  
  resources :resms, only: [:create, :show] do
    collection do
      get '/:id/new', to: 'resumes#new'
    end
  end
  resources :sttgs, only: [:update]
  resources :works, only: [:new, :create, :show, :update] do
    collection do
      get 'download'
    end
  end
end