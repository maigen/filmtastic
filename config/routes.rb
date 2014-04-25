Rails.application.routes.draw do
  # devise_for :users
  resources :maps
  resources :locations, only: [:create, :new]
  root "maps#index"


end
