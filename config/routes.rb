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
  resources :creators, only: [:show, :edit, :update] do
    collection do
      get '/:id/earning', to: 'creators#earning'
    end
  end
  resources :credits, only: [:show, :update] do
    collection do
      get '/:id/new', to: 'credits#new'
    end
  end
  resources :explanations, only: [:index, :new, :create]
  resources :exposures, only: [:index, :create, :show] do
    collection do
      get '/:id/new', to: 'exposures#new'
    end
    resources :contributors, only: [:index, :show]
  end
  resources :homes, only: [:index] do
    resources :manuals, only: [:index, :show]
  end
  resources :mangas, only: [:index, :show]  do
    resources :illustlifes, only: [:index, :show]
  end
  resources :requests, only: [:index, :create, :show, :update] do
    collection do
      get '/:id/new', to: 'requests#new'
      get 'download'
    end
  end  
  resources :resumes, only: [:create, :show] do
    collection do
      get '/:id/new', to: 'resumes#new'
    end
  end
  resources :settings, only: [:update]
  resources :works, only: [:new, :create, :show, :update]
end