# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubmittersController, type: :controller do
  let(:valid_attributes) do
    { first_name: 'Test', last_name: 'Case', college: 1, department: 'Application Development', mailing_address: '2911 Woodside', phone_number: '111-111-1111', email_address: 'test@mail.uc.edu' }
  end

  let(:invalid_attributes) do
    { first_name: '', last_name: '', college: 1, department: 'Application Development', mailing_address: '', phone_number: '', email_address: 'bad_email' }
  end

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:old_submitter) { FactoryBot.create(:submitter) }

  let(:valid_session) { { submitter_id: submitter.id } }
  let(:old_session) { { submitter_id: old_submitter.id, some_old_key: some_old_value } }

  let(:some_old_value) { 'some_old_value' }

  describe 'GET #show' do
    before do
      login_as_submitter_of(submitter)
    end
    it 'returns a success response' do
      get :show, params: { id: submitter.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    before do
      login_as_submitter_of(submitter)
    end

    it 'returns a success response' do
      get :edit, params: { id: submitter.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'clears the old session' do
        post :create, params: { submitter: valid_attributes }, session: old_session
        expect(session[:submitter_id]).to_not be(old_submitter.id)
        expect(session[:submitter_id]).to_not be_nil
        expect(session[:some_old_key]).to be_nil
      end

      it 'creates a new Submitter' do
        expect do
          post :create, params: { submitter: valid_attributes }, session: {}
        end.to change(Submitter, :count).by(1)
      end

      it 'redirects to the publications show page' do
        post :create, params: { submitter: valid_attributes }, session: {}
        expect(response).to redirect_to(publications_path)
        expect(flash[:success]).to eql 'Your account was successfully created.'
        expect(flash[:error]).to be_nil
      end
    end

    context 'with invalid params' do
      it 'renders the new template with an unprocessible entity response' do
        post :create, params: { submitter: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    before do
      login_as_submitter_of(submitter)
    end

    context 'with valid params' do
      let(:new_attributes) do
        { first_name: 'New', college: 2, department: 'Not Important', mailing_address: 'Home Address', phone_number: '513-111-1111', email_address: 'test@gmail.com' }
      end

      it 'updates the requested submitter' do
        put :update, params: { id: submitter.id, submitter: new_attributes }
        submitter.reload
        expect(submitter.first_name).to eql 'New'
        expect(submitter.last_name).to eql 'Last' # unchanged
        expect(submitter.college).to eql 2
        expect(submitter.department).to eql 'Not Important'
        expect(submitter.mailing_address).to eql 'Home Address'
        expect(submitter.phone_number).to eql '513-111-1111'
        expect(submitter.email_address).to eql 'test@gmail.com'
      end

      it 'redirects to the submitter' do
        put :update, params: { id: submitter.id, submitter: valid_attributes }
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it 'does not update the requested submitter' do
        put :update, params: { id: submitter.id, submitter: invalid_attributes }
        submitter.reload
        expect(submitter.first_name).to eql 'First' # unchanged
      end

      it 'displays the edit template and returns an unprocessible entity error' do
        put :update, params: { id: submitter.id, submitter: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'Sign out' do
    render_views

    context 'when a manager is logged in' do
      it 'it redirects to root path when finished' do
        get :finished, session: { admin: true }
        expect(response.body).to have_text('You are being redirected')
      end
    end

    context 'when a manager is not logged in' do
      it 'redirects to finished page when finished' do
        get :finished, session: { admin: nil }
        expect(response.body).to have_text('Your submission(s) was received')
      end
    end
  end

  describe 'Check date in a valid timeframe' do
    render_views
    before do
      allow(Date).to receive(:current).and_return Date.new(2020, 1, 1)
    end

    it 'Visit root path' do
      get :new
      expect(response.body).to have_text('Please complete a form for each work submitted')
    end
  end

  describe 'Check date in an invalid timeframe' do
    render_views
    before do
      allow(Date).to receive(:current).and_return Date.parse(ENV.fetch('PAST_DATE'))
    end

    it 'Visit root path' do
      get :new
      expect(response.body).to have_text('You are being redirected')
    end
  end
end
