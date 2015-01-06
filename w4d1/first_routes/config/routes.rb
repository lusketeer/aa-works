Rails.application.routes.draw do

  resources :users, except: [:edit, :new] do
    resources :contacts, only: [:index]
    resources :comments, only: [:index, :create, :destroy]
    resources :groups
  end
  resources :contacts, except: [:edit, :new, :index] do
    resources :comments, only: [:index, :create, :destroy]
    patch 'favorite', on: :member
  end
  resources :contact_shares, only: [:create, :destroy] do
    resources :comments, only: [:index, :create, :destroy]
    patch 'favorite', on: :member
  end

end
