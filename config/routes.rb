Rails.application.routes.draw do
  root to: 'hoses#index'
  resources :hoses, only:[:index, :show]
end
