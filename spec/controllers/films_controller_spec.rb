# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FilmsController, type: :controller do
  let(:valid_attributes) do
    { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => ['', '1', '4'], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'director' => 'Test', 'release_year' => 'Test' }
  end

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'], 'author_last_name' => [''], 'college_ids' => [''], 'uc_department' => '', 'work_title' => '', 'other_title' => '', 'director' => '', 'release_year' => '' }
  end

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }
  let(:film) { Film.create! valid_attributes }

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

      it 'creates a new Film' do
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
      it 'does not create a new Film' do
        expect do
          post :create, params: { film: invalid_attributes }, session: valid_session
        end.not_to change(Film, :count)
      end

      it "redirects to the 'new' template with status 'unprocessable_entity'" do
        post :create, params: { film: invalid_attributes }, session: valid_session
        expect(response).to render_template(:new)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => %w[6 7], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'volume' => 'Test', 'issue' => 'Test', 'page_numbers' => 'Test', 'director' => 'Test', 'release_year' => '2020' }
      end

      it 'updates the requested other publication' do
        put :update, params: { id: film.to_param, film: new_attributes }, session: valid_session
        film.reload
        expect(film.release_year).to eql '2020'
        expect(film.college_ids).to eql [6, 7]
      end

      it 'redirects to the film' do
        put :update, params: { id: film.to_param, film: valid_attributes }, session: valid_session
        expect(response).to redirect_to(film)
      end
    end

    context 'with invalid params' do
      it "redirects to the 'edit' template with status 'unprocessable_entity'" do
        put :update, params: { id: film.to_param, film: invalid_attributes }, session: valid_session
        expect(response).to render_template(:edit)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      film
    end

    it 'destroys the requested film' do
      expect do
        delete :destroy, params: { id: film.to_param }, session: valid_session
      end.to change(Film, :count).by(-1)
    end

    it 'redirects to the films list' do
      delete :destroy, params: { id: film.to_param }, session: valid_session
      expect(response).to redirect_to(films_url)
    end
  end
end
