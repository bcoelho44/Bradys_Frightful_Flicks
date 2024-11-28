Rails.application.routes.draw do
  # Static pages routes
  get "/about", to: "pages#about", as: :about
  get "/contact", to: "pages#contact", as: :contact

  # Home page
  root to: 'home#index'

  # Products routes
  resources :products, only: [:index, :show] do
    collection do
      get 'category/:id', to: 'products#category', as: :category
    end

    member do
      post 'add_to_cart', to: 'products#add_to_cart'
    end
  end

  # Movies routes (optional, if separate from products)
  resources :movies, only: [:index, :show]

  # Cart routes
  resources :cart, only: [:index] do
    collection do
      patch 'update', to: 'cart#update', as: :update
      delete 'remove', to: 'cart#remove', as: :remove
    end
  end

  # Orders routes
  resources :orders, only: [:new, :create, :show]

  # ActiveAdmin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # User authentication routes
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # Health check endpoint
  get 'up', to: 'rails/health#show', as: :rails_health_check

  # Progressive Web App (PWA) routes
  get 'service-worker', to: 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest', to: 'rails/pwa#manifest', as: :pwa_manifest
end
