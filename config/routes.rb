Rails.application.routes.draw do

  namespace :admin do
    get 'sessions/new'
    get 'sessions/create'
  end
  namespace :admin do
    get 'posts/index'
    get 'posts/destroy'
  end
  namespace :admin do
    get 'users/index'
    get 'users/destroy'
  end
  namespace :admin do
    get 'homes/top'
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  root 'homes#top'
  get 'about', to: 'homes#about'

  resources :users, only: [:show, :edit, :update, :destroy]

  namespace :admin do
    root to: 'homes#top' 
    resources :users, only: [:index, :destroy] 
    resources :posts, only: [:index, :destroy] 
    resources :comments, only: [:index, :destroy]
  end

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
  end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in', as: :users_guest_sign_in
  end
end
