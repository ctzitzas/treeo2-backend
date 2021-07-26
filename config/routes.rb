Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/users/:id", to: "users#show", as: "user"

  post "/sign_up", to: "users#sign_up"
  post "/login", to: "users#login"

  post "/purchase", to: "purchases#create"
  post "/webhook", to: "purchases#webhook"
end
