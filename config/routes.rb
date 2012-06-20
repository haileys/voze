Voze::Application.routes.draw do
  root to: "home#index"
  
  resource :sessions, only: [:new, :create, :destroy]
  get "/login" => "sessions#new", as: :new_sessions
  
  resources :users, only: [:show, :new, :create]
  resources :password_resets, only: [:show, :new, :create]
  resources :torrents, only: [:index, :show, :new, :create] do
    resources :versions, only: [:show, :new, :create]
  end
  resources :categories, only: [:index, :show]
  
  get "/announce", to: "announces#announce", as: :announce
end