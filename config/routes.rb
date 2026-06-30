Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Root = Inertia dashboard
  root "dashboard#index"

  # Auth
  get  "login"  => "sessions#new",     as: :login
  post "login"  => "sessions#create"
  delete "logout" => "sessions#destroy", as: :logout

  get  "register"   => "registrations#new",    as: :register
  post "register"   => "registrations#create"

  # Products (CRUD)
  resources :products, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  # PWA (optional)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
