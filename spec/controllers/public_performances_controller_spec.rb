# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicPerformancesController, type: :controller do
  let(:valid_attributes) do
    { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => ['', '1', '4'], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'location' => 'Test', 'date' => 'Test', 'time' => 'Test' }
  end

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'], 'author_last_name' => [''], 'college_ids' => [''], 'uc_department' => '', 'work_title' => '', 'other_title' => '', 'location' => '', 'date' => '', 'time' => '' }
  end

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }
  let(:public_performance) { PublicPerformance.create! valid_attributes }

  it_behaves_like 'restricts non-logged-in users', {
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
      before do
        FactoryBot.create(:submitter)
      end

      it 'creates a new Public Performance' do
        expect do
          post :create, params: { public_performance: valid_attributes }, session: valid_session
        end.to change(PublicPerformance, :count).by(1)
      end

      it 'redirects to the publication index' do
        post :create, params: { public_performance: valid_attributes }, session: valid_session
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Public Performance' do
        expect do
          post :create, params: { public_performance: invalid_attributes }, session: valid_session
        end.not_to change(PublicPerformance, :count)
      end

      it "redirects to the 'new' template with status 'unprocessable_entity'" do
        post :create, params: { public_performance: invalid_attributes }, session: valid_session
        expect(response).to render_template(:new)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => %w[6 7], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'volume' => 'Test', 'issue' => 'Test', 'page_numbers' => 'Test', 'location' => 'Test', 'date' => 'Test', 'time' => 'now' }
      end

      it 'updates the requested other publication' do
        put :update, params: { id: public_performance.to_param, public_performance: new_attributes }, session: valid_session
        public_performance.reload
        expect(public_performance.time).to eql 'now'
        expect(public_performance.college_ids).to eql [6, 7]
      end

      it 'redirects to the public_performance' do
        put :update, params: { id: public_performance.to_param, public_performance: valid_attributes }, session: valid_session
        expect(response).to redirect_to(public_performance)
      end
    end

    context 'with invalid params' do
      it "redirects to the 'edit' template with status 'unprocessable_entity'" do
        put :update, params: { id: public_performance.to_param, public_performance: invalid_attributes }, session: valid_session
        expect(response).to render_template(:edit)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      public_performance
    end

    it 'destroys the requested public_performance' do
      expect do
        delete :destroy, params: { id: public_performance.to_param }, session: valid_session
      end.to change(PublicPerformance, :count).by(-1)
    end

    it 'redirects to the publications_path' do
      public_performance = PublicPerformance.create! valid_attributes
      delete :destroy, params: { id: public_performance.to_param }, session: valid_session
      expect(response).to redirect_to(publications_path)
    end
  end
end
