Rails.application.routes.draw do
  root to: 'horses#index'
  resources :horses, only: [:index, :show]
  resources :races, only: [:index, :show] do
    resources :horses, only: [:show] do
      resources :comments, only: [:index, :create], controller: 'races/horses/comments'
    end
  end

  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  mount Sidekiq::Web => '/sidekiq'
end
