# frozen_string_literal: true

Rails.application.routes.draw do
  resources :colleges
  resources :artworks
  resources :books
  resources :book_chapters
  resources :digital_projects
  resources :editings
  resources :films
  resources :journal_articles
  resources :musical_scores
  resources :photographies
  resources :physical_media
  resources :plays
  resources :public_performances
  resources :other_publications
  resources :submitters
  get 'citations', to: 'admin#citations'
  get 'publications', to: 'publications#index'
  get 'publications/:id', to: 'publications#index'
  get 'manage', to: 'admin#login'
  post 'manage/validate', to: 'admin#validate'
  get 'finished', to: 'submitters#finished'
  get '/pages/:page' => 'pages#show'
  get '/csv/:controller_name', to: 'admin#csv', as: 'controller_name'
  root 'submitters#new'
end
