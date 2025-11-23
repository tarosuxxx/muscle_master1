Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  root 'homes#top'
  get 'about', to: 'homes#about'

  resources :users, only: [:show, :edit, :update, :destroy]

  resources :posts do
    resource :likes, only: [:create, :destroy]
  end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in', as: :users_guest_sign_in
  end
end
