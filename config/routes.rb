Rails.application.routes.draw do
  authenticate :user, ->(user) { user.admin? } do
    mount Blazer::Engine, at: "blazer"
    mount RailsAdmin::Engine, at: "/admin", as: "rails_admin"
  end

  root "dashboards#show"
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    put '/update_email', to: 'users/registrations#update_email', as: :update_email_registration
    put '/update_password', to: 'users/registrations#update_password', as: :update_password_registration
  end

  resources :people
  resources :memories
  resources :media, only: [:destroy]
  resource :dashboard, only: [:show]
end
