# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CollegesController, type: :controller do
  let(:valid_attributes) { { name: 'Test' } }
  let(:invalid_attributes) { { name: '' } }

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }

  describe 'POST #create' do
    context 'as an admin user' do
      before { session[:admin] = true }

      context 'with valid params' do
        it 'creates a new College' do
          expect do
            post :create, params: { college: valid_attributes }
          end.to change(College, :count).by(1)
        end

        it 'redirects to the created college' do
          post :create, params: { college: valid_attributes }
          expect(response).to redirect_to(College.last)
        end
      end

      context 'with invalid params' do
        it 'renders the new template with unprocessable entity status' do
          post :create, params: { college: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template(:new)
        end
      end
    end

    context 'as a non-admin user' do
      before { session[:admin] = false }

      it 'denies access and renders a 404 page' do
        post :create, params: { college: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
