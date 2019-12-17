# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "tops#show"
  get "sessions/new"
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :users do
    resource :following, only: %i[show]
    resource :followers, only: %i[show]
  end
  resources :books
  resources :users, only: %i[index show]
  resources :follows, only: %i[create destroy]
  resource :tops, only: %i[show]
end
