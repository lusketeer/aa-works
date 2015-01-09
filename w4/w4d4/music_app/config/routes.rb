Rails.application.routes.draw do
  root to: "bands#index"

  get "users/activate", to: "users#activate"
  resources :notes, only: [:create, :destroy]
  resources :tracks, except: [:new, :index]
  resources :albums, except: [:new, :index] do
    resources :tracks, only: :new
  end
  resources :bands do
    resources :albums, only: :new
  end
  resources :users
  resource :session
end
