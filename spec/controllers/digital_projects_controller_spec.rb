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
  let(:digital_project) { DigitalProject.create! valid_attributes }

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

      it 'creates a new DigitalProject' do
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
      it 'does not create a new Digital Project' do
        expect do
          post :create, params: { digital_project: invalid_attributes }, session: valid_session
        end.not_to change(DigitalProject, :count)
      end

      it "redirects to the 'new' template with status 'unprocessable_entity'" do
        post :create, params: { digital_project: invalid_attributes }, session: valid_session
        expect(response).to render_template(:new)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => %w[6 7], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'volume' => 'Test', 'issue' => 'Test', 'page_numbers' => 'Test', 'name_of_site' => 'Test', 'name_of_affiliated_organization' => 'Test', 'publication_date' => 'Test', 'version' => 'Test', 'url' => 'Test', 'doi' => 'done' }
      end

      it 'updates the requested other publication' do
        put :update, params: { id: digital_project.to_param, digital_project: new_attributes }, session: valid_session
        digital_project.reload
        expect(digital_project.doi).to eql 'done'
        expect(digital_project.college_ids).to eql [6, 7]
      end

      it 'redirects to the digital_project' do
        put :update, params: { id: digital_project.to_param, digital_project: valid_attributes }, session: valid_session
        expect(response).to redirect_to(digital_project)
      end
    end

    context 'with invalid params' do
      it "redirects to the 'edit' template with status 'unprocessable_entity'" do
        put :update, params: { id: digital_project.to_param, digital_project: invalid_attributes }, session: valid_session
        expect(response).to render_template(:edit)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      digital_project
    end
    
    it 'destroys the requested digital_project' do
      expect do
        delete :destroy, params: { id: digital_project.to_param }, session: valid_session
      end.to change(DigitalProject, :count).by(-1)
    end

    it 'redirects to the digital_projects list' do
      delete :destroy, params: { id: digital_project.to_param }, session: valid_session
      expect(response).to redirect_to(digital_projects_url)
    end
  end
end
