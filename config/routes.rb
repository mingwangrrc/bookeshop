Rails.application.routes.draw do
  get "buy_now/show"
  get "buy_now/success"
  get "reviews/index"
  get "reviews/show"
  get "pages/about"
  get "genres/index"
  get "genres/show"
  get "books/index"
  get "books/show"
  get "authors/index"
  get "authors/show"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :authors, only: [:index, :show, :new, :create]
  resources :books, only: [:index, :show, :new, :create]
  resources :genres, only: [:index, :show, :new, :create]
  resources :reviews, only: [:index, :show]

  get "welcome/index"
  get 'about', to: 'pages#about'
  root 'books#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
