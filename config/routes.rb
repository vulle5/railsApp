Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Shorthand syntax for root address "/"
  root 'pages#home'
  get 'about', to: 'pages#about'

  # Resources gives basic paths for articles like get, post, put, delete
  # and also connects controllers
  resources :articles

  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :categories, expect: [:destroy]
end
