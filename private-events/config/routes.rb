Rails.application.routes.draw do
  devise_for :users
  root "events#index"

  resources :events do
    resources :event_attendaces
  end

  resource :users, only: [:show]


end
