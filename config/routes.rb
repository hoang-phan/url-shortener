Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resources :urls
  end

  resources :tests, only: :index

  match ":shortened", to: "urls#show", via: :get
end
