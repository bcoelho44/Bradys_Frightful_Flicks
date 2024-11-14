Rails.application.routes.draw do
  # Devise routes for ActiveAdmin users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Devise routes for regular users
  devise_for :users

  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA (Progressive Web App) routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Root path route
  root to: "home#index" # Update this to the controller and action for your app's homepage
end
