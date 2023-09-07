# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminController, type: :controller do

  let(:valid_attributes) do
    { 'username' => ENV.fetch('ADMIN_USERNAME', nil), 'password' => ENV.fetch('ADMIN_PASSWORD', nil) }
  end

  let(:invalid_attributes) do
    { 'username' => 'bad', 'password' => 'invalid' }
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

  describe 'GET #citations' do
    context 'when admin is logged in' do
      before do
        allow(College).to receive(:count).and_return(2)
        allow(controller).to receive(:session).and_return(admin: true)
        allow(controller).to receive(:fetch_all_records).and_return(mocked_records)
      end

      let(:mocked_records) { [double('Artwork', college_ids: [1], uc_department: 'Art'), double('Book', college_ids: [2], uc_department: 'Literature')] }

      it 'populates @college_array with grouped records' do
        get :citations
        expect(assigns(:college_array)).to eq([[1, { 'Art' => [mocked_records.first] }], [2, { 'Literature' => [mocked_records.last] }]])
      end
    end

    context 'when admin is not logged in' do
      before do
        allow(controller).to receive(:session).and_return(admin: false)
      end

      it 'redirects to publications_path' do
        get :citations
        expect(response).to redirect_to(publications_path)
      end
    end
  end

  describe 'POST #toggle_links' do
    context 'when session[:links] is true' do
      before do
        session[:links] = true
      end

      it 'toggles session[:links] to false' do
        post :toggle_links
        expect(session[:links]).to be false
      end

      it 'redirects to citations_path' do
        post :toggle_links
        expect(response).to redirect_to(citations_path)
      end
    end

    context 'when session[:links] is false' do
      before do
        session[:links] = false
      end

      it 'toggles session[:links] to true' do
        post :toggle_links
        expect(session[:links]).to be true
      end

      it 'redirects to citations_path' do
        post :toggle_links
        expect(response).to redirect_to(citations_path)
      end
    end
  end

  # Private Methods
  describe '#fetch_all_records' do
    before do
      stub_const('AdminController::ALLOWED_CONTROLLERS_TO_MODELS', {
                   'artworks' => double('ArtworkModel'),
                   'books' => double('BookModel')
                 })
    end

    it 'fetches all records from each allowed model' do
      # Create doubles for the records
      artwork_double = double('ArtworkRecord')
      book_double = double('BookRecord')

      # Allow the models to receive :all and return the doubles
      allow(AdminController::ALLOWED_CONTROLLERS_TO_MODELS['artworks']).to receive(:all).and_return([artwork_double])
      allow(AdminController::ALLOWED_CONTROLLERS_TO_MODELS['books']).to receive(:all).and_return([book_double])

      all_records = subject.send(:fetch_all_records)

      # Verify
      expect(all_records).to match_array([artwork_double, book_double])
    end

    it 'returns an empty array if no records are present' do
      # Allow the models to receive :all and return empty arrays
      allow(AdminController::ALLOWED_CONTROLLERS_TO_MODELS['artworks']).to receive(:all).and_return([])
      allow(AdminController::ALLOWED_CONTROLLERS_TO_MODELS['books']).to receive(:all).and_return([])

      all_records = subject.send(:fetch_all_records)

      # Verify
      expect(all_records).to be_empty
    end
  end
end
