# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DigitalProjectsController, type: :controller do
  let(:valid_attributes) do
    { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => ['', '1', '4'], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'name_of_site' => 'Test', 'name_of_affiliated_organization' => 'Test', 'publication_date' => 'Test', 'version' => 'Test', 'url' => 'Test', 'doi' => 'Test' }
  end

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'], 'author_last_name' => [''], 'college_ids' => [''], 'uc_department' => '', 'work_title' => '', 'other_title' => '', 'name_of_site' => '', 'name_of_affiliated_organization' => '', 'publication_date' => '', 'version' => '', 'url' => '', 'doi' => '' }
  end

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }

  describe 'GET #index' do
    before do
      FactoryBot.create(:submitter)
    end

    it 'returns a success response' do
      DigitalProject.create! valid_attributes
      get :index, session: valid_session
      expect(response).to redirect_to('/publications')
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      digital_project = DigitalProject.create! valid_attributes
      get :show, params: { id: digital_project.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show as admin' do
    it 'returns a success response' do
      FactoryBot.create(:submitter)
      session[:admin] = true
      digital_project = DigitalProject.create! valid_attributes
      get :show, params: { id: digital_project.to_param }, session: valid_session
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
      digital_project = DigitalProject.create! valid_attributes
      get :edit, params: { id: digital_project.to_param }, session: valid_session
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
          post :create, params: { digital_project: valid_attributes }, session: valid_session
        end.to change(DigitalProject, :count).by(1)
      end

      it 'redirects to the publication index' do
        post :create, params: { digital_project: valid_attributes }, session: valid_session
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { digital_project: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => %w[6 7], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'volume' => 'Test', 'issue' => 'Test', 'page_numbers' => 'Test', 'name_of_site' => 'Test', 'name_of_affiliated_organization' => 'Test', 'publication_date' => 'Test', 'version' => 'Test', 'url' => 'Test', 'doi' => 'done' }
      end

      it 'updates the requested other publication' do
        digital_project = DigitalProject.create! valid_attributes
        put :update, params: { id: digital_project.to_param, digital_project: new_attributes }, session: valid_session
        digital_project.reload
        expect(digital_project.doi).to eql 'done'
        expect(digital_project.college_ids).to eql [6, 7]
      end

      it 'redirects to the digital_project' do
        digital_project = DigitalProject.create! valid_attributes
        put :update, params: { id: digital_project.to_param, digital_project: valid_attributes }, session: valid_session
        expect(response).to redirect_to(digital_project)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        digital_project = DigitalProject.create! valid_attributes
        put :update, params: { id: digital_project.to_param, digital_project: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested digital_project' do
      digital_project = DigitalProject.create! valid_attributes
      expect do
        delete :destroy, params: { id: digital_project.to_param }, session: valid_session
      end.to change(DigitalProject, :count).by(-1)
    end

    it 'redirects to the digital_projects list' do
      digital_project = DigitalProject.create! valid_attributes
      delete :destroy, params: { id: digital_project.to_param }, session: valid_session
      expect(response).to redirect_to(digital_projects_url)
    end
  end
end
