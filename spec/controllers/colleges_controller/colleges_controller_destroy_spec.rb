# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CollegesController, type: :controller do
  let(:valid_attributes) { { name: 'Test' } }

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }

  describe 'DELETE #destroy' do
    let(:college) { College.create! valid_attributes }

    context 'as an admin user' do
      before { session[:admin] = true }

      it 'destroys the requested college' do
        expect do
          delete :destroy, params: { id: college.to_param }
        end.to change(College, :count).by(-1)
      end

      it 'redirects to the colleges list' do
        delete :destroy, params: { id: college.to_param }
        expect(response).to redirect_to(colleges_url)
      end
    end

    context 'as a non-admin user' do
      before { session[:admin] = false }

      it 'does not destroy the college' do
        expect do
          delete :destroy, params: { id: college.to_param }, session: valid_session
        end.to change(College, :count).by(0)
      end

      it 'renders a 404 page' do
        delete :destroy, params: { id: college.to_param }, session: valid_session
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
