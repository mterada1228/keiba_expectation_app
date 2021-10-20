Rails.application.routes.draw do
  root to: 'horses#index'
  resources :horses, only: [:index, :show]
  resources :races, only: [:index, :show]
  resources :horse_races, only: [] do
    resources :comments, only: [:index, :show, :create]
  end
  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  mount Sidekiq::Web => '/sidekiq'
end
