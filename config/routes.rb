Rails.application.routes.draw do

  # TODO: authtenticate admin user
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root "dashboards#show"
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :people
  resources :memories
  resources :media, only: [:destroy]
  resource :dashboard, only: [:show]
end
