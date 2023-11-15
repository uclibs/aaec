# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FilmsController, type: :controller do
  let(:valid_attributes) do
    { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => ['', '1', '4'], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'director' => 'Test', 'release_year' => 'Test', 'submitter_id' => '1' }
  end

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'], 'author_last_name' => [''], 'college_ids' => [''], 'uc_department' => '', 'work_title' => '', 'other_title' => '', 'director' => '', 'release_year' => '' }
  end

  let(:valid_session) { { submitter_id: 1 } }

  describe 'GET #index' do
    before do
      FactoryBot.create(:submitter)
    end

    it 'returns a success response' do
      Film.create! valid_attributes
      get :index, session: valid_session
      expect(response).to redirect_to('/publications')
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      film = Film.create! valid_attributes
      get :show, params: { id: film.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show as admin' do
    it 'returns a success response' do
      FactoryBot.create(:submitter)
      session[:admin] = true
      film = Film.create! valid_attributes
      get :show, params: { id: film.to_param }, session: valid_session
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
      film = Film.create! valid_attributes
      get :edit, params: { id: film.to_param }, session: valid_session
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
          post :create, params: { film: valid_attributes }, session: valid_session
        end.to change(Film, :count).by(1)
      end

      it 'redirects to the publication index' do
        post :create, params: { film: valid_attributes }, session: valid_session
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { film: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => %w[6 7], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'volume' => 'Test', 'issue' => 'Test', 'page_numbers' => 'Test', 'director' => 'Test', 'release_year' => '2020' }
      end

      it 'updates the requested other publication' do
        film = Film.create! valid_attributes
        put :update, params: { id: film.to_param, film: new_attributes }, session: valid_session
        film.reload
        expect(film.release_year).to eql '2020'
        expect(film.college_ids).to eql [6, 7]
      end

      it 'redirects to the film' do
        film = Film.create! valid_attributes
        put :update, params: { id: film.to_param, film: valid_attributes }, session: valid_session
        expect(response).to redirect_to(film)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        film = Film.create! valid_attributes
        put :update, params: { id: film.to_param, film: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested film' do
      film = Film.create! valid_attributes
      expect do
        delete :destroy, params: { id: film.to_param }, session: valid_session
      end.to change(Film, :count).by(-1)
    end

    it 'redirects to the films list' do
      film = Film.create! valid_attributes
      delete :destroy, params: { id: film.to_param }, session: valid_session
      expect(response).to redirect_to(films_url)
    end
  end
end
