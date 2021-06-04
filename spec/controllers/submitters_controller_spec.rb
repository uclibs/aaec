# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubmittersController, type: :controller do
  let(:valid_attributes) do
    { first_name: 'Test', last_name: 'Case', college: 1, department: 'Application Development', mailing_address: '2911 Woodside', phone_number: '111-111-1111', email_address: 'test@mail.uc.edu' }
  end

  let(:invalid_attributes) do
    { first_name: '', last_name: '', college: 1, department: 'Application Development', mailing_address: '', phone_number: '', email_address: 'bad_email' }
  end

  let(:valid_session) { {} }

  describe 'GET #show' do
    it 'returns a success response' do
      submitter = Submitter.create! valid_attributes
      get :show, params: { id: submitter.to_param }, session: valid_session
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
      submitter = Submitter.create! valid_attributes
      get :edit, params: { id: submitter.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Submitter' do
        expect do
          post :create, params: { submitter: valid_attributes }, session: valid_session
        end.to change(Submitter, :count).by(1)
      end

      it 'redirects to the publications show page' do
        post :create, params: { submitter: valid_attributes }, session: valid_session
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { submitter: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { first_name: 'New', last_name: 'Submitter', college: 2, department: 'Not Important', mailing_address: 'Home Address', phone_number: '513-111-1111', email_address: 'test@gmail.com' }
      end

      it 'updates the requested submitter' do
        submitter = Submitter.create! valid_attributes
        put :update, params: { id: submitter.to_param, submitter: new_attributes }, session: valid_session
        submitter.reload
        expect(submitter.first_name).to eql 'New'
        expect(submitter.last_name).to eql 'Submitter'
        expect(submitter.college).to eql 2
        expect(submitter.department).to eql 'Not Important'
        expect(submitter.mailing_address).to eql 'Home Address'
        expect(submitter.phone_number).to eql '513-111-1111'
        expect(submitter.email_address).to eql 'test@gmail.com'
      end

      it 'redirects to the submitter' do
        submitter = Submitter.create! valid_attributes
        put :update, params: { id: submitter.to_param, submitter: valid_attributes }, session: valid_session
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        submitter = Submitter.create! valid_attributes
        put :update, params: { id: submitter.to_param, submitter: invalid_attributes }, session: valid_session
        expect(response).to be_successful
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
