# frozen_string_literal: true

# spec/controllers/errors_controller_spec.rb

require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do
  describe 'GET #not_found' do
    before do
      get :not_found
    end
    it 'renders the not_found template' do
      expect(response).to render_template('errors/404')
      expect(response).to render_template('layouts/application')
    end

    it 'returns HTTP status 404' do
      expect(response).to have_http_status(404)
    end
  end

  describe 'GET #unprocessable_entity' do
    before do
      get :unprocessable_entity
    end

    it 'renders the unprocessable_entity template' do
      expect(response).to render_template('errors/422')
      expect(response).to render_template('layouts/application')
    end

    it 'returns HTTP status 422' do
      expect(response).to have_http_status(422)
    end
  end

  describe 'GET #internal_server_error' do
    before do
      get :internal_server_error
    end
    it 'renders the internal_server_error template' do
      expect(response).to render_template('errors/500')
      expect(response).to render_template('layouts/application')
    end

    it 'returns HTTP status 500' do
      expect(response).to have_http_status(500)
    end
  end
end
