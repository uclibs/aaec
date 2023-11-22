# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MusicalScoresController, type: :controller do
  let(:valid_attributes) do
    { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => ['', '1', '4'], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'publisher' => 'Test', 'city' => 'Test', 'publication_date' => 'Test', 'url' => 'Test', 'doi' => 'Test' }
  end

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'], 'author_last_name' => [''], 'college_ids' => [''], 'uc_department' => '', 'work_title' => '', 'other_title' => '', 'publisher' => '', 'city' => '', 'publication_date' => '', 'url' => '', 'doi' => '' }
  end

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }
  let(:musical_score) { MusicalScore.create! valid_attributes }

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

      it 'creates a new MusicalScore' do
        expect do
          post :create, params: { musical_score: valid_attributes }, session: valid_session
        end.to change(MusicalScore, :count).by(1)
      end

      it 'redirects to the publication index' do
        post :create, params: { musical_score: valid_attributes }, session: valid_session
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a new MusicalScore' do
        expect do
          post :create, params: { musical_score: invalid_attributes }, session: valid_session
        end.not_to change(MusicalScore, :count)
      end

      it "redirects to the 'new' template with status 'unprocessable_entity'" do
        post :create, params: { musical_score: invalid_attributes }, session: valid_session
        expect(response).to render_template(:new)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'PUT #update' do


    context 'with valid params' do
      let(:new_attributes) do
        { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => %w[6 7], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'volume' => 'Test', 'issue' => 'Test', 'page_numbers' => 'Test', 'publisher' => 'Test', 'city' => 'Test', 'publication_date' => 'Test', 'url' => 'www.cool.com', 'doi' => 'Test' }
      end

      it 'updates the requested other publication' do
        put :update, params: { id: musical_score.to_param, musical_score: new_attributes }, session: valid_session
        musical_score.reload
        expect(musical_score.url).to eql 'www.cool.com'
        expect(musical_score.college_ids).to eql [6, 7]
      end

      it 'redirects to the musical_score' do
        put :update, params: { id: musical_score.to_param, musical_score: valid_attributes }, session: valid_session
        expect(response).to redirect_to(musical_score)
      end
    end

    context 'with invalid params' do
      it "redirects to the 'edit' template with status 'unprocessable_entity'" do
        put :update, params: { id: musical_score.to_param, musical_score: invalid_attributes }, session: valid_session
        expect(response).to render_template(:edit)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      musical_score
    end

    it 'destroys the requested musical_score' do
      expect do
        delete :destroy, params: { id: musical_score.to_param }, session: valid_session
      end.to change(MusicalScore, :count).by(-1)
    end

    it 'redirects to the musical_scores list' do
      delete :destroy, params: { id: musical_score.to_param }, session: valid_session
      expect(response).to redirect_to(musical_scores_url)
    end
  end
end
