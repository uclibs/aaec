# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a publication with show action' do |model_name|
  let(:submitter) { FactoryBot.create(:submitter) }
  let(:other_submitter) { FactoryBot.create(:submitter) }
  let(:publication) { FactoryBot.create(model_name, submitter:) }
  let(:other_publication) { FactoryBot.create(model_name, submitter: other_submitter) }

  before do
    submitter
    other_submitter
    publication
    other_publication
  end

  context 'as a submitter' do
    before { login_as_submitter_of(publication) }

    it 'shows the publication' do
      get :show, params: { id: publication.id }
      expect(response).to have_http_status(:ok)
      expect(assigns(model_name.to_sym)).to eq(publication)
    end

    it 'does not show other publications' do
      expect { get :show, params: { id: other_publication.id } }.to raise_error(ActionController::RoutingError, 'Not Found')
    end

    it 'does not assign the submitter' do
      expect(assigns(:submitter)).to be_nil
    end
  end

  context 'as an admin' do

    it 'assigns the submitter' do
      get :show, params: { id: publication.id }, session: { admin: true }
      expect(assigns(:submitter)).to eq(submitter)
    end

    it 'shows the publication' do
      get :show, params: { id: publication.id }, session: { admin: true }
      expect(response).to have_http_status(:ok)
      expect(assigns(model_name.to_sym)).to eq(publication)
    end
  end
end
