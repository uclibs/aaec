# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do
  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }
  let(:invalid_session) { { submitter_id: nil } }

  context 'when a user is logged in' do
    describe 'GET #not_found' do
      before do
        get :not_found, session: valid_session, format: :html
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

  context 'when a user is not logged in' do
    describe 'GET #not_found' do
      before do
        get :not_found, session: invalid_session
      end
      it 'redirects to the root page' do
        expect(response).to redirect_to(root_path)
        expect(response).to have_http_status(302)
      end
    end
  end
end
