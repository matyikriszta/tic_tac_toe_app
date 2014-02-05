TicTacToeApp::Application.routes.draw do
  resources :players

  resources :moves

  resources :games do
    member do
      post "/make_move/:square", to: "games#make_move", as: 'make_move'
    end
  end

  get "/login", to: "sessions#new"
  get "/logout", to: "sessions#destroy", as: :logout

  resources :sessions   

  root to: 'games#index'

end
