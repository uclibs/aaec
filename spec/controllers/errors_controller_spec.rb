# frozen_string_literal: true

# spec/controllers/errors_controller_spec.rb

require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do
  describe 'GET #not_found' do
    let(:submitter) { FactoryBot.create(:submitter) }
    let(:valid_session) { { submitter_id: submitter.id } }

    before do
      get :not_found, session: valid_session
    end

    it 'renders the not_found template' do
      expect(response).to render_template('errors/404')
      expect(response).to render_template('layouts/application')
    end

    it 'returns HTTP status 404' do
      expect(response).to have_http_status(404)
    end
  end
end
