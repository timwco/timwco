Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

  resources :articles, only: [:index, :show]
  resources :projects, only: [:index, :show]

  get 'about',    to: 'pages#about'  
  get 'music',    to: 'pages#music'
  get 'wishlist', to: 'pages#wishlist'

  root 'pages#index'
end
