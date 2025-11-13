Rails.application.routes.draw do
  namespace :madmin do
    resources :assets
    resources :albums
    resources :contents
    resources :posts
  end
  draw :admin
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "pages#index"

  # Pages
  get "now" => "pages#now", as: :now
  get "links" => "pages#links", as: :links
  get "tools" => "pages#tools", as: :tools
  get "book" => "pages#book", as: :book
  get "music" => "pages#music", as: :music
  get "wishlist" => "pages#wishlist", as: :wishlist

  get "styleguide" => "pages#styleguide", as: :styleguide

  # Blog routes
  get "thoughts" => "posts#index", as: :thoughts

  # Catch-all route for blog posts (must be last!)
  get ":slug" => "posts#show", as: :post, constraints: { slug: /[a-z0-9-]+/ }
end
