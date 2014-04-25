Rails.application.routes.draw do
  # devise_for :users
  resources :maps
  resources :locations, only: [:create, :new]
  match('locations/seed', {via: :post, to: 'locations#seed'})
  root "maps#index"


end
