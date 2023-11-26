Rails.application.routes.draw do
  root "dashboards#show"

  devise_for :users

  resources :people, except: [:index]
  resources :memories
  resource :dashboard, only: [:show]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
