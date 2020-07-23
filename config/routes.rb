Rails.application.routes.draw do
  resources :tickets do
    resources :comments, only: %i[create update destroy]
    resources :meetings, only: %i[new create]

    member do
      post :toggle_resolve
      post :toggle_public
      get :public_show
    end

    collection do
      get :faq
      get :pending
      get :resolved
    end
  end

  resources :topics, only: :show

  resources :meetings, only: %i[index show destroy] do
    post :toggle_accepted, on: :member #view helper for accepted meeting class
  end

  devise_for :users, path: '',
                     path_names: {
                       sign_in: 'signin',
                       sign_out: 'logout',
                       sign_up: 'signup'
                      },
                     controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :users do
    authenticated do
      root 'tickets#faq', as: :user_root
    end

    unauthenticated do
      root 'pages#home'
    end
  end
end
