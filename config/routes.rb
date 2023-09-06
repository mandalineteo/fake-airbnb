Rails.application.routes.draw do
  devise_for :users
  get 'listings/index'
  get "listings/:id", to: "listings#show"
  # root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "listings#index"
end
