Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Shorthand syntax for root address "/"
  root 'pages#home'
  get 'about', to: 'pages#about'
end
