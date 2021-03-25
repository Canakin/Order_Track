Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'stats', to: 'pages#stats'
  get 'dashboard', to: 'pages#dashboard'
  get 'contact', to: 'pages#contact'
  resources :customers
  resources :orders
  resources :products, only: [:show, :new, :create] do
    resources :feedbacks, only: [:edit, :update, :new, :create, :destroy]
  end
end
