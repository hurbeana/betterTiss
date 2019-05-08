# frozen_string_literal: true

Rails.application.routes.draw do
  root   'sessions#new'

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

  # projects
  get   '/projects/search'
  get   '/projects/(:id)', to: 'projects#show', as: :projects
  put   '/projects/favorite', to: 'projects#favorite', as: :projects_favorite

  # theses
  get   '/theses/search'
  get   '/theses/(:id)', to: 'theses#show', as: :theses
  put   '/theses/favorite', to: 'theses#favorite', as: :theses_favorite

  resources :users
end
