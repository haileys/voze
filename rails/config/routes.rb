Voze::Application.routes.draw do
  root to: "home#index"
  
  resource :sessions, only: [:new, :create, :destroy]
  
  resources :users, only: [:show, :new, :create]
end
