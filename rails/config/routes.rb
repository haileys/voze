Voze::Application.routes.draw do
  root to: "home#index"
  
  resource :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:show, :new, :create]
  resources :password_resets, only: [:new, :create, :show]
end
