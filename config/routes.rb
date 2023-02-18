Rails.application.routes.draw do
  get 'agrees/show'
  devise_for :users, controllers: { registrations: 'users/registrations',
  sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks'}
  root to: 'homes#index'

  resources :agrees, only: [:show]
  resources :cards, only: [:new, :show] do
    collection do
      post 'show', to: 'cards#show'
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
    end
  end
  resources :chars, only: [:index, :create, :show] do
    collection do
        get '/:id/new', to: 'chars#new'
      end
    end
  resources :cres, only: [:show, :edit, :update] do
    collection do
      get '/:id/earning', to: 'cres#earning'
    end
  end
  resources :crs, only: [:show, :update] do
    collection do; get '/:id/new', to: 'crs#new'; end
  end
  resources :expls, only: [:index, :new, :create]
  resources :expors do
    resources :ovrs, only: [:create, :show, :edit, :destroy, :update] do
      collection do
        get '/:id/new', to: 'ovrs#new'
        get 'down'
      end
    end
    collection do; get '/:id/new', to: 'expors#new'; end
  end
  resources :homes, only: [:index] do
    resources :mans, only: [:index, :show]
  end
  resources :paths, only: [:show]
  resources :reqs, only: [:index, :create, :show, :update] do
    collection do
      get '/:id/new', to: 'reqs#new'
    end
  end
  resources :resms, only: [:create, :show] do
    collection do
      get '/:id/new', to: 'resms#new'
    end
  end
  resources :sttgs, only: [:update]
  resources :ttls, only: [:index, :new, :create, :edit, :show, :update]
  resources :works, only: [:new, :create, :show, :update] do
    collection do
      get 'download'
    end
  end
end