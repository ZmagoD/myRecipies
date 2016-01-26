Rails.application.routes.draw do
  devise_for :chefs
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#home'
  resources :recipes do
    member do
      post 'like'
    end
    collection do
      post :search, to: "recipes#search"
    end
    resources :comments
  end
  
  resources :chefs, except: [:new, :destroy]
  
  # get '/register', to: 'chefs#new'
  
  # get '/login', to: 'logins#new'
  # post '/login', to: 'logins#create'
  # get '/logout', to: 'logins#destroy'
  
  resources :styles, only: [ :new, :show, :create ]
  resources :ingredients, only: [ :new, :show, :create ]
end
