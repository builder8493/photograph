Rails.application.routes.draw do
  root to: 'top#home'
  resources :users, except: [:index]
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :posts, except: :index do
    get :hashtag, on: :member
  end
  resources :relationships, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
