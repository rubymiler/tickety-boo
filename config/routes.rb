Rails.application.routes.draw do
  resources :tickets do
    resources :comments
  end

  resources :topics, only: %i[index show]

  devise_for :users, path: '',
                     path_names: {
                       sign_in: 'login',
                       sign_out: 'logout',
                       sign_up: 'signup'
                      },
                     controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # devise_scope :user do
  #   root 'tickets#index', as: :user_root
  # end

  root 'pages#home'
end
