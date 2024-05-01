Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get '/home/about', to: 'homes#about'
  root to: "homes#top"
  devise_for :users
  
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update]
  resources :relationships, only: [:index,:show,:create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:show] do
    member do
      post 'follow' => 'relationships#create'
      delete 'unfollow' => 'relationships#destroy'
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
  end
end