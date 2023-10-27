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
    let(:other_submitter) { FactoryBot.create(:submitter) }
    let(:other_session) { { submitter_id: other_submitter.id } }

    it 'redirects to the 404 page' do
      expect do
        get :edit, params: { id: new_instance.id }, session: other_session
      end.to raise_error(ActionController::RoutingError, 'Not Found')
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
