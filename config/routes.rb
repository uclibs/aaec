# frozen_string_literal: true

Rails.application.routes.draw do
  resources :colleges
  resources :books
  resources :other_publications
  resources :submitters
  get 'publications', to: 'publications#index'
  get 'publications/:id', to: 'publications#index'
  get 'admin', to: 'admin#login'
  post 'admin/validate', to: 'admin#validate'
  get 'finished', to: 'submitters#finished'
  get '/pages/:page' => 'pages#show'
  root 'submitters#new'
end
