Rails.application.routes.draw do
  resources :tickets do
    resources :comments
    member do
      post :toggle_status
    end
  end

  resources :posts

  resources :topics, only: %i[index show]

  devise_for :users, path: '',
                     path_names: {
                       sign_in: 'signin',
                       sign_out: 'logout',
                       sign_up: 'signup'
                      },
                     controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  mount ActionCable.server => '/cable'

  devise_scope :users do
    authenticated do
      root 'tickets#index', as: :user_root
    end

    unauthenticated do
      root 'pages#home'
    end
  end
end
