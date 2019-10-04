Rails.application.routes.draw do
  root 'static_pages#home'
  get 'sessions/new'
  get  '/help',           to: 'static_pages#help'
  get  '/about',          to: 'static_pages#about'
  get  '/contact',        to: 'static_pages#contact'
  get  '/signup',         to: 'users#new'
  post '/signup',         to: 'users#create'
  get    '/login',        to: 'sessions#new'
  post   '/login',        to: 'sessions#create'
  delete '/logout',       to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :edit, :create, :update]
  resources :microposts,          only: [:create, :show, :destroy] do
    resources :comments
  end
  resources :relationships,       only: [:create, :destroy]
  resources :likes,               only: [:create, :destroy]
end
