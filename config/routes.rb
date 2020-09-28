Rails.application.routes.draw do
  get 'races/index'
  root to: 'hoses#index'
  resources :hoses, only:[:index, :show]
  resources :races, only:[:index, :show]
end
