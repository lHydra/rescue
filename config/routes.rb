Rails.application.routes.draw do
  root 'home#index'
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
  resource :users do 
    resource :posts
  end
  resource :sessions
  get 'posts', to: 'posts#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
