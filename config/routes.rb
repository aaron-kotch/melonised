Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resources :todos
  resources :projects
  resources :chat, only: [ :create, :show, :index ]

  post "chat/get_wallet", to: "chat#get_wallet", as: :get_wallet
  post "chat/get_trending", to: "chat#get_trending", as: :get_trending
  post "chat/get_coins", to: "chat#get_coins", as: :get_coins

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "projects#index"
end
