Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :items, only: [:index, :show]
  resources :categories, only: [:show]

  get '/cart', to: "cart#index"
  post '/cart', to: "cart#create"
  delete '/cart', to: "cart#destroy"
  patch '/cart', to: "cart#update"

  root 'sessions#index'

  get '/login', to: 'sessions#new'



end
