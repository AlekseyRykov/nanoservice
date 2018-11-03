Rails.application.routes.draw do
  root to: "articles#index"

  devise_for :users
  resources :users

  resources :articles
  resources :hipchats, only: [:index, :show]
  resources :slacks, only: [:index, :show]
  resources :telegrams, only: [:index, :show]
  resources :messengers, only: [:index]

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
