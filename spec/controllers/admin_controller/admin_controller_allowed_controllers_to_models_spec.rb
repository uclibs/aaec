# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminController, type: :controller do
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
