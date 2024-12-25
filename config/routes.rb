Rails.application.routes.draw do
  get "home/index"

  resources :schedules, only: [ :create, :show, :update, :destroy ]

  resources :progress, only: [ :create, :index, :destroy ]
  #REGISTRATION
  resources :users, only: [ :new, :create, :show ]
  resources :users do
    resources :exercises, only: [ :edit, :index, :new, :create ]
  end

  get 'train_schedules/:user_id', to: 'train_schedules#index', as: 'train_schedules'
  get 'schedule/:user_id' => 'train_schedules#show'
  get 'home', to: 'home#index'

  #LOGIN
  root 'sessions#new'
  #get 'login', to: 'sessions#new', as: 'login'    # Форма для логина
  #post 'login', to: 'sessions#create'               # Логин
  #delete 'logout', to: 'sessions#destroy', as: 'logout'  # Выход


  resource :session, only: [ :new, :create, :destroy ]
end