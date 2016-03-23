Rails.application.routes.draw do
  root 'links#new'
  get "sessions/new"
  resources :users
  get "/links", to: "links#new"
  resources :links

  get    "login"   => 'sessions#new'
  post   "login"   => 'sessions#create'
  delete "logout"  => 'sessions#destroy'
  get "/:slug" => 'links#show'
end
