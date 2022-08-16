Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resources :urls
  end

  match ":shortened", to: "urls#show", via: :get
end
