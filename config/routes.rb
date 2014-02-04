TicTacToeApp::Application.routes.draw do
  resources :players

  resources :moves

  resources :games

  get "/login", to: "sessions#new"
  get "/logout", to: "sessions#destroy", as: :logout

  resources :sessions   

  root to: 'games#index'

end
