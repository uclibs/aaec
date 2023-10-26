# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a publication with show action' do |model_name|
  let(:submitter) { FactoryBot.create(:submitter) }
  let(:other_submitter) { FactoryBot.create(:submitter) }
  let(:publication) { FactoryBot.create(model_name, submitter_id: submitter.id) }
  let(:other_publication) { FactoryBot.create(model_name, submitter_id: other_submitter.id) }

  before do
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
      get :show, params: { id: other_publication.id }
      expect { value }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'does not assign the submitter' do
      expect(assigns(:submitter)).to be_nil
    end
  end

  context 'as an admin' do
    before do
      session[:admin] = true
      get :show, params: { id: publication.id }
    end

    it 'assigns the submitter' do
      expect(assigns(:submitter)).to eq(submitter)
    end

    it 'shows the publication' do
      expect(response).to have_http_status(:ok)
      expect(assigns(model_name.to_sym)).to eq(publication)
    end
  end
end
