Rails.application.routes.draw do
  get "sessions/new"

  resources :users
  resources :links
  root 'links#new'
  get    "login"   => 'sessions#new'
  post   "login"   => 'sessions#create'
  delete "logout"  => 'sessions#destroy'
  get "/:slug" => 'links#show'
end
