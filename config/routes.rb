Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "welcome#index"

  namespace :merchant, as: :merchant_dash do
    resources :orders, only: [:show, :update]
    resources :items, only: [:index]
    get "/", to: "dashboard#index"
  end

  namespace :admin, as: :admin_dash do
    resources :users, only: [:index, :show]
    resources :merchants, only: [:show]
    resources :orders, only: [:update]
    get "/", to: "dashboard#index"
  end

  resources :merchants do
    resources :items, only: [:index, :new, :create]
  end

  resources :items, except: [:new, :create] do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [:edit, :update, :destroy]
  resources :orders, only: [:new, :create, :show, :update]

  get "/register", to: "users#new"
  post "/register", to: "users#create"
  get "/profile", to: "users#show"
  get "/profile/edit", to: "users#edit"
  patch "/profile", to: "users#update"
  get "/profile/edit_password", to: "users#edit_password"
  get "/profile/orders", to: "orders#index"
  get "/profile/orders/:id", to: "orders#show"
  delete "/profile/orders/:id", to: "orders#cancel"

  post "/cart/:item_id", to: "cart#add_item"
  patch "/cart/:item_id", to: "cart#add_subtract_cart"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"


end
