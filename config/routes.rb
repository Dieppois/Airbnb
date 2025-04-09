Rails.application.routes.draw do
  devise_for :users
  get 'home/index'

  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  namespace :api do
    resources :wishlists, only: [:create, :destroy]
  end
end
