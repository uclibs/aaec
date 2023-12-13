# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicPerformancesController, type: :controller do
  let(:valid_attributes) do
    { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => ['', '1', '4'], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'location' => 'Test', 'date' => 'Test', 'time' => 'Test', 'submitter_id' => submitter.id.to_s }
  end

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'], 'author_last_name' => [''], 'college_ids' => [''], 'uc_department' => '', 'work_title' => '', 'other_title' => '', 'location' => '', 'date' => '', 'time' => '' }
  end

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:public_performance) { FactoryBot.create(:public_performance, submitter_id: submitter.id) }

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
    before do
      session[:submitter_id] = submitter.id
    end
    context 'with valid params' do
      it 'creates a new Public Performance with the correct sumbitter_id' do
        expect do
          post :create, params: { public_performance: valid_attributes }
        end.to change(PublicPerformance, :count).by(1)

        created_public_performance = PublicPerformance.last
        expect(created_public_performance.submitter_id).to eq(submitter.id.to_s)
      end

      it 'redirects to the publication index' do
        post :create, params: { public_performance: valid_attributes }
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Public Performance' do
        expect do
          post :create, params: { public_performance: invalid_attributes }
        end.not_to change(PublicPerformance, :count)
      end

      it "redirects to the 'new' template with status 'unprocessable_entity'" do
        post :create, params: { public_performance: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'PUT #update' do
    before do
      login_as_submitter_of(public_performance)
    end

    context 'with valid params' do
      let(:new_attributes) do
        { 'college_ids' => %w[6 7], 'time' => 'now' }
      end

      it 'updates the requested public performance' do
        put :update, params: { id: public_performance.id, public_performance: new_attributes }
        public_performance.reload
        expect(public_performance.author_first_name).to eql %w[First Second] # verify unchanged
        expect(public_performance.time).to eql 'now'
        expect(public_performance.college_ids).to eql [6, 7]
      end

      it 'redirects to the public_performance' do
        put :update, params: { id: public_performance.id, public_performance: new_attributes }
        expect(response).to redirect_to(public_performance)
      end
    end

    context 'with invalid params' do
      it "redirects to the 'edit' template with status 'unprocessable_entity'" do
        put :update, params: { id: public_performance.id, public_performance: invalid_attributes }
        expect(response).to render_template(:edit)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      public_performance
      login_as_submitter_of(public_performance)
    end

    it 'destroys the requested public_performance' do
      expect do
        delete :destroy, params: { id: public_performance.id }
      end.to change(PublicPerformance, :count).by(-1)
    end

    it 'redirects to the publications_path' do
      delete :destroy, params: { id: public_performance.id }
      expect(response).to redirect_to(publications_path)
    end
  end
end
