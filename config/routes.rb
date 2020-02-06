# frozen_string_literal: true

Rails.application.routes.draw do
  resources :colleges
  resources :books
  resources :other_publications
  resources :submitters
  get 'publications', to: 'publications#index'
  get 'publications/:id', to: 'publications#index'
  get 'admin', to: 'admin#login'
  get 'signout', to: 'submitters#sign_out'
  post 'admin/validate', to: 'admin#validate'
  root 'submitters#new'
end
