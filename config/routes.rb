Rails.application.routes.draw do
  root to: 'books#index'
  get 'sessions/new'
  devise_for :users, module: :users
  resources :users, only: [:index, :show]
  resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
