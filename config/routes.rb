Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Root = Inertia dashboard
  root "dashboard#index"

  # Reveal health status on /up
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
