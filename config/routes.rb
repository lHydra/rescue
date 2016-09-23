Rails.application.routes.draw do
  root 'home#index'
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
  resource :users 
  resources :posts
  resource :sessions
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
