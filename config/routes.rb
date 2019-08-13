Rails.application.routes.draw do
  devise_for :users
  root to: 'articles#index'
  resources :articles,　only: [:index, :new, :create, :edit, :update, :destroy]
end
