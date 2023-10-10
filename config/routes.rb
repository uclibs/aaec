# frozen_string_literal: true

Rails.application.routes.draw do
  # Resource routes
  resources :artworks
  resources :book_chapters
  resources :books
  resources :colleges
  resources :digital_projects
  resources :editings
  resources :films
  resources :journal_articles
  resources :musical_scores
  resources :other_publications
  resources :photographies
  resources :physical_media
  resources :plays
  resources :public_performances
  resources :submitters

  # Admin-related routes
  get 'citations', to: 'admin#citations'
  get 'toggle_links', to: 'admin#toggle_links'
  get 'manage', to: 'admin#login'
  post 'manage/validate', to: 'admin#validate'
  get '/csv/:controller_name', to: 'admin#csv', as: 'controller_name'

  # Publications and submission routes
  get 'publications', to: 'publications#index'
  get 'publications/:id', to: 'publications#index'
  get 'finished', to: 'submitters#finished'

  # Dynamic pages
  get '/pages/:page' => 'pages#show'

  # Root URL
  root 'submitters#new'

  # Custom Error Pages
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#not_found', via: :all
end
