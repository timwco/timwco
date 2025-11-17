# Below are the routes for madmin
namespace :madmin, path: :admin do
  resources :wishlist_items
  resources :tools do
    collection do
      get :import
      post :process_import
    end
  end
  resources :collections
  resources :assets
  resources :albums
  resources :categories
  resources :contents
  resources :posts do
    collection do
      get :import
      post :process_import
    end
  end
  root to: "dashboard#show"
end