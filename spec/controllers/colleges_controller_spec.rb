# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CollegesController, type: :controller do
  let(:valid_attributes) do
    { name: 'Test' }
  end

  let(:invalid_attributes) do
    { name: '' }
  end

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }

  describe 'GET #index' do
    it 'returns a success response' do
      College.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      college = College.create! valid_attributes
      get :show, params: { id: college.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      college = College.create! valid_attributes
      get :edit, params: { id: college.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

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
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { college: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { name: 'Test2' }
      end

      it 'updates the requested college' do
        college = College.create! valid_attributes
        put :update, params: { id: college.to_param, college: new_attributes }, session: valid_session
        college.reload
        college.name == new_attributes[:name]
      end

      it 'redirects to the college' do
        college = College.create! valid_attributes
        put :update, params: { id: college.to_param, college: valid_attributes }, session: valid_session
        expect(response).to redirect_to(college)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        college = College.create! valid_attributes
        put :update, params: { id: college.to_param, college: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested college' do
      college = College.create! valid_attributes
      expect do
        delete :destroy, params: { id: college.to_param }, session: valid_session
      end.to change(College, :count).by(-1)
    end

    it 'redirects to the colleges list' do
      college = College.create! valid_attributes
      delete :destroy, params: { id: college.to_param }, session: valid_session
      expect(response).to redirect_to(colleges_url)
    end
  end
end
