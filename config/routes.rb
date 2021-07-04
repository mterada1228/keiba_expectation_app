Rails.application.routes.draw do
  root to: 'horses#index'
  resources :horses, only: [:index, :show]
  resources :races, only: [:index, :show] do
    resources :horses, only: [:show] do
      resources :positive_comments, only: [:index], controller: 'races/horses/positive_comments'
      resources :negative_comments, only: [:index], controller: 'races/horses/negative_comments'
    end
  end

  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  mount Sidekiq::Web => '/sidekiq'
end
