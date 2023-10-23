# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicationsController, type: :controller do
  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }

  let(:other_publication) { FactoryBot.create(:other_publication) }

  let(:common_attributes) do
    { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'volume' => 'Test', 'issue' => 'Test', 'page_numbers' => 'Test', 'publisher' => 'Test', 'city' => 'Test', 'publication_date' => 'Test', 'doi' => 'Test', 'submitter_id' => submitter.id }
  end

  let(:valid_attributes) do
    common_attributes.merge('college_ids' => ['', '1', '4'], 'url' => 'Test')
  end

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'], 'author_last_name' => [''], 'college_ids' => [''], 'uc_department' => '', 'work_title' => '', 'other_title' => '', 'volume' => '', 'issue' => '', 'page_numbers' => '', 'publisher' => '', 'city' => '', 'publication_date' => '', 'url' => '', 'doi' => '' }
  end

  describe 'GET #index' do
    before { login_as_submitter_of(other_publication) }

    it 'returns a success response' do
      get :index
      expect(response).to be_successful
      expect(response).to redirect_to('/publications')
    end
  end

  describe 'GET #show' do
    before { login_as_submitter_of(other_publication) }

    it 'returns a success response' do
      get :show, params: { id: other_publication.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #show as admin' do
    before do
      session[:admin] = true
      session[:submitter_id] = nil
    end

    it 'returns a success response' do
      get :show, params: { id: other_publication.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    before { login_as_submitter_of(other_publication) }

    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    before { login_as_submitter_of(other_publication) }

    it 'returns a success response' do
      get :edit, params: { id: other_publication.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    before { login_as_submitter_of(other_publication) }

    context 'with valid params' do
      it 'creates and verifies a new Other Publication' do
        expect do
          post :create, params: { other_publication: valid_attributes }
        end.to change(OtherPublication, :count).by(1)

        created_publication = OtherPublication.last
        expect(created_publication.author_first_name).to eq(%w[Test Person])
        # ...more attributes checks

        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { other_publication: invalid_attributes }
        expect(response).to be_successful
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    before { login_as_submitter_of(other_publication) }

    context 'with valid params' do
      let(:new_attributes) do
        common_attributes.merge('college_ids' => %w[6 7], 'url' => 'www.cool.com')
      end

      it 'updates the requested other publication' do
        put :update, params: { id: other_publication.to_param, other_publication: new_attributes }
        other_publication.reload
        expect(other_publication.url).to eql('www.cool.com')
        expect(other_publication.college_ids).to eql([6, 7])

        expect(response).to redirect_to(other_publication)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: other_publication.to_param, other_publication: invalid_attributes }
        expect(response).to be_successful
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login_as_submitter_of(other_publication) }

    it 'destroys the requested other_publication' do
      expect do
        delete :destroy, params: { id: other_publication.to_param }
      end.to change(OtherPublication, :count).by(-1)
      expect(response).to redirect_to(other_publications_url)
    end
  end
end
