Rails.application.routes.draw do
  devise_for :users
  # root to: "pages#home"
  # Define yourp application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "listings#index"
  resources :listings, only: %i[show new create destroy] do
    resources :bookings, only: %i[new create edit update]
    resources :unavailable_dates, only: %i[index create]
  end
  resources :bookings, only: %i[index] do
    collection do
      get :host, :stats
    end

    member do
      patch :confirm
      patch :decline
    end
  end
end
