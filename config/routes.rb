Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "topics#index"
  get "/topics", to: "topics#show"

  resources :topics
  resources :pages
  resources :tags

  get "signup", to: "users#new", as: "signup"
  resources :users, only: [:create]

  # delete "cities/:city_id/activities/:activity_id", to: "activities#destroy", as: "delete_activity"
  post "search", to: "search#index", as: "search"
  get "login", to: "sessions#new", as: "login"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: "logout"
end
