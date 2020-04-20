Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  root to: "posts#index"
  resources :users, except: [:index]
  resources :posts, only: [:new, :create, :index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
