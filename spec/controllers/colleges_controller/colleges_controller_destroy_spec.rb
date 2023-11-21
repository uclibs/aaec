# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CollegesController, type: :controller do
  let(:valid_attributes) { { name: 'Test' } }

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }

  describe 'DELETE #destroy' do
    let(:college) { College.create! valid_attributes }
    context 'as an admin user' do
      before do
        session[:admin] = true
      end

      it 'destroys the requested college' do
        college = FactoryBot.create(:college)

        expect do
          delete :destroy, params: { id: college.to_param }
        end.to change(College, :count).by(-1)

        expect(response).to redirect_to(colleges_url)
        expect(flash[:warning]).to eq('College was successfully destroyed.')
      end
    end

    context 'as a non-admin user' do
      before do
        session[:admin] = false
      end

      it 'does not destroy the college' do
        college = FactoryBot.create(:college)

        expect do
          delete :destroy, params: { id: college.to_param }
        end.not_to change(College, :count)

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
