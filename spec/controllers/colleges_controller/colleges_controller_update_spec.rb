# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CollegesController, type: :controller do
  let(:valid_attributes) { { name: 'Test' } }
  let(:invalid_attributes) { { name: '' } }

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }

  describe 'PUT #update' do
    let(:college) { College.create! valid_attributes }
    let(:new_attributes) { { name: 'Test2' } }

    context 'as an admin user' do
      before { session[:admin] = true }

      context 'with valid params' do
        it 'updates the requested college' do
          put :update, params: { id: college.to_param, college: new_attributes }
          college.reload
          expect(college.name).to eq(new_attributes[:name])
        end

        it 'redirects to the college' do
          put :update, params: { id: college.to_param, college: new_attributes }
          expect(response).to redirect_to(college)
        end
      end

      context 'with invalid params' do
        it 'redirects to the edit template with unprocessable entity status' do
          put :update, params: { id: college.to_param, college: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template(:edit)
        end
      end
    end

    context 'as a non-admin user' do
      before { session[:admin] = false }

      it 'denies access and renders a 404 page for valid params' do
        put :update, params: { id: college.to_param, college: new_attributes }, session: valid_session
        expect(response).to have_http_status(:not_found)
      end

      it 'denies access and renders a 404 page for invalid params' do
        put :update, params: { id: college.to_param, college: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
