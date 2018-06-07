Rails.application.routes.draw do
  resources :recipients, only: [:index, :new, :create]
  root to: 'home#index'

  resources :credentials
  post 'credentials/:id/verify', to: 'credentials#verify', as: 'verify_credential'

  get 'login', to: redirect('/auth/google_oauth2'), as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
end
