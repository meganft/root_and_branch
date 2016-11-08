Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :items, only: [:index, :show]
  # resources :categories, only: [:show]
  #

  get '/cart', to: 'cart#show'
  post '/cart', to: 'cart#create'
  delete '/cart', to: 'cart#destroy'
  patch '/cart', to: 'cart#update'

  root 'sessions#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create, :show]

  resources :orders, only: [:index, :show, :create]

  get '/dashboard', to: 'users#show'

  get '/:slug', :to => 'categories#show', as: :category

  namespace :admin do
    get '/dashboard', to: 'dashboard#show'
    patch '/dashboard', to: 'dashboard#update'
    resources :users, only: [:edit, :update]
    resources :items, only: [:index, :edit, :update, :show]
    # post '/items/:id/edit', to: 'items#update', as: :edit_admin_item
  end



end
