Rails.application.routes.draw do
  get 'boards/index'
  get 'boards/show' #modifications here
  get 'boards/all'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "boards#index"
end
