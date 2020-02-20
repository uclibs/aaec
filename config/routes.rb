# frozen_string_literal: true

Rails.application.routes.draw do
  resources :colleges
  resources :books
  resources :other_publications
  resources :submitters
  get 'publications', to: 'publications#index'
  get 'publications/:id', to: 'publications#index'
  get 'manage', to: 'admin#login'
  post 'manage/validate', to: 'admin#validate'
  get 'finished', to: 'submitters#finished'
  get '/pages/:page' => 'pages#show'
  root 'submitters#new'
end
