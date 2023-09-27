# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  include ApplicationHelper

  controller do

    def index
      raise ActiveRecord::RecordNotFound
    end

    def action_404
      raise ActiveRecord::RecordNotFound
    end

    def action_422
      raise ActionController::UnprocessableEntity
    end

    def action_500
      raise StandardError, 'This is a standard error'
    end
  end

  describe 'rescue_from ActiveRecord::RecordNotFound' do
    before do
      routes.draw { get 'index' => 'anonymous#index', as: :index }
    end


    it 'renders the not_found template' do
      puts
      puts "response: #{response.inspect}"
      puts
      expect(controller).to receive(:render_404)
      get :index
    end

    it 'returns HTTP status 404' do
      get :action_404
      expect(response).to have_http_status(404)
    end
  end

  describe 'rescue_from ActionController::UnprocessableEntity' do
    before do
      routes.draw { get 'action_422' => 'anonymous#action_422' }
    end

    it 'renders the unprocessable_entity template' do
      get :action_422
      expect(response).to render_template('errors/422')
    end

    it 'returns HTTP status 422' do
      get :action_422
      expect(response).to have_http_status(422)
    end
  end

  describe 'rescue_from StandardError' do
    before do
      routes.draw { get 'action_500' => 'anonymous#action_500' }
    end

    it 'renders the internal_server_error template' do
      get :action_500
      expect(response).to render_template('errors/500')
    end

    it 'returns HTTP status 500' do
      get :action_500
      expect(response).to have_http_status(500)
    end

    it 'logs the error' do
      allow(controller.logger).to receive(:error)
      get :action_500
      expect(controller.logger).to have_received(:error).with(an_instance_of(StandardError).and(having_attributes(message: 'This is a standard error')))
    end
  end
end
