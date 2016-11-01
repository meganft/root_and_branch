Rails.application.routes.draw do
  resources :items, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :categories, only: [:show]

  get '/cart', to: "cart#index"
  post '/cart', to: "cart#create"

end
