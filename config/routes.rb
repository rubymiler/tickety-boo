Rails.application.routes.draw do
  resources :tickets
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # TODO: add user_root_path

  root 'pages#home'
end