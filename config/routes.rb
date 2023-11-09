Rails.application.routes.draw do
  root "memories#index"

  devise_for :users

  resources :people, except: [:index]
  resources :memories, except: [:index]

  # get "/dashboard" => "users#dashboard", as: :dashboard
end
