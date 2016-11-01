Rails.application.routes.draw do
  resources :items, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :categories, only: [:show]

  get '/cart', to: "cart#index"
  post '/cart', to: "cart#create"

  root 'sessions#index'

  get '/login', to: 'sessions#new'

  resources :users, only: [:new, :create, :show]

  get '/dashboard', to: 'users#show'

end
