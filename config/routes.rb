Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'stats', to: 'pages#stats'
  get 'dashboard', to: 'pages#dashboard'
  get 'contact', to: 'pages#contact'
  resources :customers do
    resources :orders, only: [:new, :create]
  end
  resources :orders, only: [:index, :show, :edit, :update, :destroy] do
    resources :products, only: [:new, :create]
  end
  resources :products, only: [:show ] do
    resources :feedbacks, only: [:edit, :update, :new, :create, :destroy]
  end
end
