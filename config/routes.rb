Rails.application.routes.draw do
  root to: 'current_recruting_events#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:new, :create]
  
  resources :boards, only: [:new, :create, :destroy, :index, :show]
  resources :current_recruting_events, only: [:new, :create, :destroy, :index, :show]
  resources :tournament_results, only: [:new, :create, :destroy, :index, :show]
  resources :tournaments, only: [:index]
  resources :others, only: [:index]
  resources :practice_results, only: [:new, :create, :destroy, :index, :show]
end
