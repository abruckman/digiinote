Rails.application.routes.draw do


  resources :notes

  # get 'notes', to:'notes#index'
  # post 'notes', to:'notes#create'
  # get 'notes/new', to:'notes#new'
  # get 'notes/:id', to: 'notes#show'
  # get 'notes/:id/edit', to: 'notes#edit'
  get '/getcamera', to: 'notes#get_camera'
  get '/oauth2', to:'sessions#save_google'
  get '/oauth2callback', to: 'sessions#create_callback'

  get 'sessions/new', to: 'sessions#new'

  post '/upload', to: 'notes#create'


  root to: "notes#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
