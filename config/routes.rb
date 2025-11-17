Rails.application.routes.draw do
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
  get "book" => "pages#book", as: :book
  get "music" => "pages#music", as: :music
  get "tools" => "pages#tools", as: :tools  
  get "wishlist" => "pages#wishlist", as: :wishlist

  # Blog routes
  get "thoughts" => "posts#index", as: :thoughts

  # Redirects (301 permanent)
  get "blog", to: redirect("/thoughts", status: 301)
  get "about", to: redirect("/", status: 301)

  # Category route (checked first - takes precedence over post slugs)
  get ":slug" => "categories#show", as: :category,
      constraints: ->(req) { Category.exists?(slug: req.params[:slug]) }

  # Catch-all route for blog posts (must be last!)
  get ":slug" => "posts#show", as: :post, constraints: { slug: /[a-z0-9-]+/ }
end
