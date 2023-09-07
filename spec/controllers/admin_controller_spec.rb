# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  let(:valid_attributes) do
    { 'username' => ENV.fetch('ADMIN_USERNAME', nil), 'password' => ENV.fetch('ADMIN_PASSWORD', nil) }
  end

  let(:invalid_attributes) do
    { 'username' => 'bad', 'password' => 'invalid' }
  end

  describe 'POST #validate' do
    it 'returns a success response' do
      post :validate, params: valid_attributes
      expect(response).to redirect_to('/publications')
    end

    it 'returns a error response' do
      post :validate, params: invalid_attributes
      expect(response.status).to eq 302
    end
  end

  describe 'GET #login' do
    it 'Visit manage path before expiration date' do
      allow(Date).to receive(:current).and_return Date.parse(ENV.fetch('EXPIRATION_DATE'))
      get(:login, params: { :format => 'html', 'controller_name' => 'admin_controller' }, session: { 'admin' => false })
      expect(response.status).to eq 200
    end

    it 'Visit manage path after expiration date' do
      allow(Date).to receive(:current).and_return Date.parse(ENV.fetch('PAST_DATE'))
      get(:login, params: { :format => 'html', 'controller_name' => 'admin_controller' }, session: { 'admin' => false })
      expect(response.status).to eq 200
    end
  end

  describe 'GET #csv' do
    it 'returns a csv when admin' do
      get(:csv, params: { :format => 'csv', 'controller_name' => 'other_publications' }, session: { 'admin' => true })
      expect(response.status).to eq 200
    end

    it 'redirects when invalid format and admin' do
      get(:csv, params: { :format => 'html', 'controller_name' => 'other_publications' }, session: { 'admin' => true })
      expect(response).to redirect_to('/publications')
    end

    it 'redirects when not admin but valid' do
      get(:csv, params: { :format => 'csv', 'controller_name' => 'other_publications' })
      expect(response).to redirect_to('/publications')
    end
  end

  describe 'ALLOWED_CONTROLLERS_TO_MODELS' do
    let(:excluded_model_names) { ['ActiveRecord::InternalMetadata', 'ActiveRecord::SchemaMigration', 'ApplicationRecord', 'College', '...eges', 'HABTM_Colleges', 'HABTM_Books', 'HABTM_OtherPublications'] }

    def load_all_models
      Dir[Rails.root.join('app/models/**/*.rb')].each { |file| require file }
    end

    def fetch_all_model_names
      ActiveRecord::Base.descendants.map(&:name).sort
    end

    def fetch_allowed_model_names
      AdminController::ALLOWED_CONTROLLERS_TO_MODELS.values.map(&:to_s).sort
    end

    before(:all) do
      load_all_models
    end

    it 'contains all the relevant models in app/models' do
      all_model_names = fetch_all_model_names
      allowed_model_names = fetch_allowed_model_names
      relevant_model_names = (all_model_names - excluded_model_names).sort
      expect(allowed_model_names).to match_array(relevant_model_names)
    end

    it 'each model should have a to_csv class method' do
      missing_methods = []

      AdminController::ALLOWED_CONTROLLERS_TO_MODELS.each_value do |model|
        missing_methods << "#{model.name} is missing a to_csv class method" unless model.respond_to?(:to_csv)
      end

      expect(missing_methods).to be_empty, missing_methods.join(', ')
    end
  end
end
