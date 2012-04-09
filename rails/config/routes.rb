Voze::Application.routes.draw do
  root to: "home#index"
  
  resource :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:show, :new, :create]
  resources :password_resets, only: [:show, :new, :create]
  resources :torrents, only: [:index, :show, :new, :create]
  
  match "/announce", to: "announces#announce", as: :announce
end