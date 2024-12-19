Rails.application.routes.draw do
  post '/users/register', to: 'users#register'
  resources :users, only: [:show, :update, :destroy]

  resources :exercises, only: [:create, :index, :update, :destroy]

  resources :schedules, only: [:create, :show, :update, :destroy]

  resources :progress, only: [:create, :index, :destroy]

  post '/auth/login', to: 'auth#login'
  get '/auth/me', to: 'auth#me'
end