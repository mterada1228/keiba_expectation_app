Rails.application.routes.draw do
  root :to => 'horses#index'
  resources :horses, :only => [:index, :show]
  resources :races, :only => [:index, :show]
end
