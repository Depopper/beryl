Rails.application.routes.draw do


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'users#new'

  get '/login', to: 'sessions#new', as: :new_session
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :destroy_session

  get '/profil', to: 'users#edit', as: :profil
  patch '/profil', to: 'users#update'
  resources :users, only: [:new, :create]
end
