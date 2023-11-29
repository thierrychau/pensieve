Rails.application.routes.draw do
  root "dashboards#show"
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :people
  resources :memories
  resources :media, only: [:destroy]
  resource :dashboard, only: [:show]
end
