Rails.application.routes.draw do
  resources :hipchats
  resources :slacks
  resources :telegrams
  resources :messengers
  devise_for :users

  root to: "articles#index"

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :articles
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
