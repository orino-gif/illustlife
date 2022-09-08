Rails.application.routes.draw do
  
  devise_for :users, controllers: { registrations: 'users/registrations',
    sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks'}
    
  root to: 'homes#index'
  
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

  
  get 'credits/:id/new', to: 'credits#new'
  # get 'creators/:id/earning', to: 'creators#earning'
  resources :resumes, only: [:create, :show] do
    collection do
      get '/:id/new', to: 'resumes#new'
    end
  end
  resources :mangas, only: [:index, :show]  do
    resources :illustlifes, only: [:index, :show]
  end
  resources :credits, only: [:create, :show, :update]
  resources :homes, only: [:index] do
    resources :manuals, only: [:index, :show]
  end
  
  resources :requests, only: [:index, :create, :show, :update] do
    collection do
      get '/:id/new', to: 'requests#new'
      get 'download'
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
