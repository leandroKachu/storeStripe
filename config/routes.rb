Rails.application.routes.draw do

  root 'products#index'
  resources :products
  resources :checkout, only: [:create]
  get '/checkout/success', to: 'checkout#success'

  resources :webhooks, only: [:create]


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
