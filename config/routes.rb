# frozen_string_literal: true

Rails.application.routes.draw do
  root   'static_pages#home'
  get    '/help', to: 'static_pages#help'
  get    '/about', to: 'static_pages#about'
  get    '/signup', to: 'users#new'
  post   '/signup', to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/people/search'
  get    '/people/(:id)', to: 'people#show', as: :people
  put    '/people/favorite', to: 'people#favorite', as: :people_favorite
  resources :users
end
