Rails.application.routes.draw do
  root to: "goals#index"
  resources :users, only: [:new, :create, :index, :show] do
    resources :comments, only: [:new]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :goals do
    resources :comments, only: [:new]
    patch "complete", on: :member
  end
  resources :comments, only: [:create]
end
