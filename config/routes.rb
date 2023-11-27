Rails.application.routes.draw do
  root "dashboards#show"

  devise_for :users

  resources :people
  resources :memories
  resource :dashboard, only: [:show]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
