Rails.application.routes.draw do
  authenticate :user, ->(user) { user.admin? } do
    mount RailsAdmin::Engine, at: "admin", as: "rails_admin"
  end

  root "dashboards#show"
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :people
  resources :memories
  resources :media, only: [:destroy]
  resource :dashboard, only: [:show]
end
