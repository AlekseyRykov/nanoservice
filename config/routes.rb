Rails.application.routes.draw do
  devise_for :users

  root to: "articles#index"

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
