Rails.application.routes.draw do
  root 'home#index'
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/results', to: 'results#index'
  resource :users 
  resources :posts
  resource :sessions

  namespace :admin do
    get '', to: 'dashboard#index'
    resources :posts
    resources :users
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
