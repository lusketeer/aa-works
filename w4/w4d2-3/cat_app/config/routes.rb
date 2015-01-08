Rails.application.routes.draw do
  root to: "cats#index"
  resources :cats, except: [:destroy]
  resources :cat_rental_requests do
    patch "approve", to: "cat_rental_requests#approve"
    patch "deny", to: "cat_rental_requests#deny"
  end

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
end
