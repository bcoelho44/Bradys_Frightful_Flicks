Rails.application.routes.draw do
  get "pages/about"
  # Home page
  root to: 'home#index'

  # Products routes
  resources :products, only: [:index, :show] do
    collection do
      get 'category/:id', to: 'products#category', as: :category
    end
  end

  # Movies routes (if needed separately from products)
  resources :movies, only: [:index, :show]

  # ActiveAdmin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # User authentication routes
  devise_for :users

  get "/about", to: "pages#about", as: :about
  get "/contact", to: "pages#contact", as: :contact



  # Health check endpoint
  get 'up', to: 'rails/health#show', as: :rails_health_check

  # Progressive Web App (PWA) routes
  get 'service-worker', to: 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest', to: 'rails/pwa#manifest', as: :pwa_manifest
end
