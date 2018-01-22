Rails.application.routes.draw do

  get '/contact', to: 'contacts#new'
  post '/contact', to: 'contacts#create'
  resources :queries

  root 'contacts#new'
end
