Rails.application.routes.draw do
  root to: "bands#index"

  resources :notes, only: [:create, :destroy]
  resources :tracks, except: [:new, :index]
  resources :albums, except: [:new, :index] do
    resources :tracks, only: :new
  end
  resources :bands do
    resources :albums, only: :new
  end
  resources :users do
    get "activate", on: :collection
  end
  resource :session
end
