# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicPerformancesController, type: :controller do
  let(:valid_attributes) do
    { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => ['', '1', '4'], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'location' => 'Test', 'date' => 'Test', 'time' => 'Test' }
  end

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'], 'author_last_name' => [''], 'college_ids' => [''], 'uc_department' => '', 'work_title' => '', 'other_title' => '', 'location' => '', 'date' => '', 'time' => '' }
  end

  let(:valid_session) { { submitter_id: 1 } }

  describe 'GET #index' do
    before do
      FactoryBot.create(:submitter)
    end

    it 'returns a success response' do
      PublicPerformance.create! valid_attributes
      get :index, session: valid_session
      expect(response).to redirect_to('/publications')
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      public_performance = PublicPerformance.create! valid_attributes
      get :show, params: { id: public_performance.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show as admin' do
    it 'returns a success response' do
      FactoryBot.create(:submitter)
      session[:admin] = true
      public_performance = PublicPerformance.create! valid_attributes
      get :show, params: { id: public_performance.to_param }, session: valid_session
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
      public_performance = PublicPerformance.create! valid_attributes
      get :edit, params: { id: public_performance.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      before do
        FactoryBot.create(:submitter)
      end

      it 'creates a new Other Publication' do
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
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { public_performance: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => %w[6 7], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'volume' => 'Test', 'issue' => 'Test', 'page_numbers' => 'Test', 'location' => 'Test', 'date' => 'Test', 'time' => 'now' }
      end

      it 'updates the requested other publication' do
        public_performance = PublicPerformance.create! valid_attributes
        put :update, params: { id: public_performance.to_param, public_performance: new_attributes }, session: valid_session
        public_performance.reload
        expect(public_performance.time).to eql 'now'
        expect(public_performance.college_ids).to eql [6, 7]
      end

      it 'redirects to the public_performance' do
        public_performance = PublicPerformance.create! valid_attributes
        put :update, params: { id: public_performance.to_param, public_performance: valid_attributes }, session: valid_session
        expect(response).to redirect_to(public_performance)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        public_performance = PublicPerformance.create! valid_attributes
        put :update, params: { id: public_performance.to_param, public_performance: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested public_performance' do
      public_performance = PublicPerformance.create! valid_attributes
      expect do
        delete :destroy, params: { id: public_performance.to_param }, session: valid_session
      end.to change(PublicPerformance, :count).by(-1)
    end

    it 'redirects to the public_performances list' do
      public_performance = PublicPerformance.create! valid_attributes
      delete :destroy, params: { id: public_performance.to_param }, session: valid_session
      expect(response).to redirect_to(public_performances_url)
    end
  end
end
