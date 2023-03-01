Rails.application.routes.draw do
  devise_for :users

  root 'products#index'
  resources :products
  resources :checkout, only: [:create]
  get '/checkout/success', to: 'checkout#success'

  resources :webhooks, only: [:create]
  get "success", to: "checkout#success"
  get "cancel", to: "checkout#cancel"
  
  post "products/add_to_cart/:id", to: "products#add_to_cart", as: "add_to_cart"
  delete "products/remove_from_cart/:id", to: "products#remove_from_cart", as: "remove_from_cart"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
