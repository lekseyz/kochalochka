Rails.application.routes.draw do
  resources :users, only: [:show, :update, :destroy]

  resources :exercises, only: [:create, :index, :update, :destroy]

  resources :schedules, only: [:create, :show, :update, :destroy]

  resources :progress, only: [:create, :index, :destroy]


  get '/users/:id', to: 'users#show', as: 'user_profile'

  root 'users#new'

  get '/users/register', to: 'users#new', as: 'new_user'

  post '/users/register', to: 'users#create'

  resources :users, only: [:new, :create]
end