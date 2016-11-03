Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :items, only: [:index, :show]
  resources :categories, only: [:show], param: :slug
  #
  # get '/grocery', to: 'categories#show'

  get '/cart', to: "cart#index"
  post '/cart', to: "cart#create"
  delete '/cart', to: "cart#destroy"
  patch '/cart', to: "cart#update"

  root 'sessions#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create, :show]

  resources :orders, only: [:index, :show]

  get '/dashboard', to: 'users#show'

  get "/:slug", :to => "categories#show"

  # map.category_link '/:slug', :controller => 'categories', :action => 'show'
end
