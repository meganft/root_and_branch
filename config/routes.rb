Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :items, only: [:index, :show]
  resources :categories, only: [:show]

  get '/cart', to: "cart#index"
  post '/cart', to: "cart#create"
  delete '/cart', to: "cart#destroy"

  root 'sessions#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create, :show]

  get '/dashboard', to: 'users#show'
end
