# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'books#index'
  get 'sessions/new'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users, only: %i[index show]
  resources :relationships, only: %i[create destroy]
  resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
