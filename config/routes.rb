Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: "users#index"

  post "/sign_up", to: "users#sign_up"
  post "/login", to: "users#login"
  post "/update", to: "users#update"
  post "/destroy", to: "users#destroy"

  post "/purchase", to: "purchases#create"
  post "/webhook", to: "purchases#webhook"
end
