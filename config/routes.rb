Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :articles, only: [:index, :show]
  resources :projects, only: [:index, :show]

  get 'about', to: 'pages#about'  
  get 'wishlist', to: 'pages#wishlist'

  root 'pages#index'
end
