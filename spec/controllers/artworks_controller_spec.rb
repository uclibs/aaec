# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArtworksController, type: :controller do
  let(:valid_attributes) do
    { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => ['', '1', '4'], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'location' => 'Test', 'date' => 'Test' }
  end

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'], 'author_last_name' => [''], 'college_ids' => [''], 'uc_department' => '', 'work_title' => '', 'other_title' => '', 'location' => '', 'date' => '' }
  end

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }

  describe 'GET #index' do
    before do
      FactoryBot.create(:submitter)
    end

    it 'returns a success response' do
      Artwork.create! valid_attributes
      get :index, session: valid_session
      expect(response).to redirect_to('/publications')
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      artwork = Artwork.create! valid_attributes
      get :show, params: { id: artwork.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show as admin' do
    it 'returns a success response' do
      FactoryBot.create(:submitter)
      session[:admin] = true
      artwork = Artwork.create! valid_attributes
      get :show, params: { id: artwork.to_param }, session: valid_session
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
      artwork = Artwork.create! valid_attributes
      get :edit, params: { id: artwork.to_param }, session: valid_session
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
          post :create, params: { artwork: valid_attributes }, session: valid_session
        end.to change(Artwork, :count).by(1)
      end

      it 'redirects to the publication index' do
        post :create, params: { artwork: valid_attributes }, session: valid_session
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { artwork: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => %w[6 7], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'volume' => 'Test', 'issue' => 'Test', 'page_numbers' => 'Test', 'location' => 'Test', 'date' => 'new date' }
      end

      it 'updates the requested other publication' do
        artwork = Artwork.create! valid_attributes
        put :update, params: { id: artwork.to_param, artwork: new_attributes }, session: valid_session
        artwork.reload
        expect(artwork.date).to eql 'new date'
        expect(artwork.college_ids).to eql [6, 7]
      end

      it 'redirects to the artwork' do
        artwork = Artwork.create! valid_attributes
        put :update, params: { id: artwork.to_param, artwork: valid_attributes }, session: valid_session
        expect(response).to redirect_to(artwork)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        artwork = Artwork.create! valid_attributes
        put :update, params: { id: artwork.to_param, artwork: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested artwork' do
      artwork = Artwork.create! valid_attributes
      expect do
        delete :destroy, params: { id: artwork.to_param }, session: valid_session
      end.to change(Artwork, :count).by(-1)
    end

    it 'redirects to the artworks list' do
      artwork = Artwork.create! valid_attributes
      delete :destroy, params: { id: artwork.to_param }, session: valid_session
      expect(response).to redirect_to(artworks_url)
    end
  end
end
