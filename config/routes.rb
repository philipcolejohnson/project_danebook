Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#new"

  post "login" => "sessions#create"
  post "logout" => "sessions#destroy"

  resources :users do
    member do
      get :about
      get :feed
    end

    resources :friendships, shallow: true
    resources :photos do
      resources :likes, defaults: { likable: 'Photo' }
      resources :comments, defaults:  { commentable: 'Photo' }
    end

    resources :posts, shallow: true do
      resources :likes, defaults: { likable: 'Post' }
      resources :comments, defaults:  { commentable: 'Post' }
    end
  end

  resources :comments, except: [:index, :create, :new] do
    resources :likes, defaults: { likable: 'Comment' }
    resources :comments, defaults:  { commentable: 'Comment' }
  end

  resource :session, :only => [:new, :create, :destroy]
end
