# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CollegesController, type: :controller do
  let(:valid_attributes) { { name: 'Test' } }
  let(:invalid_attributes) { { name: '' } }
  let(:valid_session) { { admin: true } }

  let(:college) { FactoryBot.create(:college, valid_attributes) }

  it_behaves_like 'restricts to only admin access', {
    'index' => :get,
    'show' => :get,
    'new' => :get,
    'edit' => :get,
    'create' => :post,
    'update' => :put,
    'destroy' => :delete
  }

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new College' do
        expect do
          post :create, params: { college: valid_attributes }, session: valid_session
        end.to change(College, :count).by(1)
      end

      it 'redirects to the created college' do
        post :create, params: { college: valid_attributes }, session: valid_session
        expect(response).to redirect_to(College.last)
      end
    end

    context 'with invalid params' do
      it 'renders the :new template with an unprocessable_entity response for invalid attributes' do
        post :create, params: { college: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end

      it 'does not create a new College' do
        expect do
          post :create, params: { college: invalid_attributes }, session: valid_session
        end.to_not change(College, :count)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'Test2' } }

      it 'updates the requested college' do
        put :update, params: { id: college.id, college: new_attributes }, session: valid_session
        college.reload
        expect(college.name).to eq(new_attributes[:name])
      end

      it 'redirects to the college' do
        put :update, params: { id: college.id, college: valid_attributes }, session: valid_session
        expect(response).to redirect_to(college)
      end
    end

    context 'with invalid params' do
      it 'renders the :edit template with an unprocessable_entity response for invalid attributes' do
        put :update, params: { id: college.id, college: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { college } # create the college before the test so that it can be destroyed
    it 'destroys the requested college' do
      expect do
        delete :destroy, params: { id: college.id }, session: valid_session
      end.to change(College, :count).by(-1)
    end

    it 'redirects to the colleges list' do
      delete :destroy, params: { id: college.id }, session: valid_session
      expect(response).to redirect_to(colleges_url)
    end
  end
end
