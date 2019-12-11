# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "books#index"
  get "sessions/new"
  devise_for :users, module: :users
  resources :users, only: %i[index show]
  resources :books
end
