Rails.application.routes.draw do
  root to: 'home#index'
  resources :warehouses, only: [:show, :new, :create, :update, :edit, :destroy]
  resources :suppliers, only: [:index, :show, :new, :create, :update, :edit]
  resources :product_models, only: [:index, :new, :create, :show]
end
