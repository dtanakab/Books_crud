# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "users#top"
  get "sessions/new"
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :users do
    collection do
      get :top
    end
  end
  resources :books, :reports, :comments
  resources :users, only: %i[index show]
end
