Rails.application.routes.draw do

  devise_for :users

  root to: "homes#top"

  resources :users, only: [:show, :edit, :update, :index, :create] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :chats, only: [:show, :create, :destroy]

  get "search" => "searches#search"

  get 'home/about' => 'homes#about', as: 'about'
  patch 'users/:id' => 'users#update', as: 'update_user'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
