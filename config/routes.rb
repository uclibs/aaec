# frozen_string_literal: true

Rails.application.routes.draw do
  resources :colleges
  resources :books
  resources :other_publications
  resources :submitters
  get 'publications', to: 'publications#index'
  root 'submitters#new'
end
