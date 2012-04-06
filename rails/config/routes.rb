Voze::Application.routes.draw do
  root to: "home#index"
  
  resource :user_sessions, only: [:new, :create, :destroy]
end
