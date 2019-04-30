# frozen_string_literal: true

Rails.application.routes.draw do
  get 'courses/show'
  get 'courses/search'
  root   'static_pages#home'
  get    '/help', to: 'static_pages#help'
  get    '/about', to: 'static_pages#about'
  get    '/signup', to: 'users#new'
  post   '/signup', to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # people
  get    '/people/search'
  get    '/people/(:id)', to: 'people#show', as: :people
  put    '/people/favorite', to: 'people#favorite', as: :people_favorite

  # courses
  get    '/courses/search'
  get    '/courses/(:id)', to: 'courses#show', as: :courses
  put    '/courses/favorite', to: 'courses#favorite', as: :courses_favorite

  resources :users
end
