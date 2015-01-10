Rails.application.routes.draw do
  root to: 'subs#index'

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts, except: [:destroy]
  resources :comments, except: [:new, :edit, :update] do
    resources :comments, only: :new
  end
end
