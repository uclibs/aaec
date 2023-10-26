# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a publication with edit action' do |model_name|
  let(:new_instance) { FactoryBot.create(model_name) }
  context 'as the correct submitter' do
    before { login_as_submitter_of(new_instance) }

    it 'returns a success response' do
      get :edit, params: { id: new_instance.id }
      expect(response).to be_successful
      expect(response).to render_template('edit')
    end
  end

  context 'as the incorrect submitter' do
    before do
      new_submitter = FactoryBot.create(:submitter)
      session[:submitter_id] = new_submitter.id
    end

    it 'redirects to the 404 page' do
      get :edit, params: { id: new_instance.id }
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'as an admin' do
    before do
      session[:admin] = true
      session[:submitter_id] = nil
    end
    it 'returns a success response' do
      get :edit, params: { id: new_instance.id }
      expect(response).to be_successful
      expect(response).to render_template('edit')
    end
  end
end
