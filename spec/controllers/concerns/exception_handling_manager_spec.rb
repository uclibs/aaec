# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExceptionHandlingManager, type: :controller do
  controller(ApplicationController) do
    include ExceptionHandlingManager

    def index
      render plain: 'Hello, world!'
    end
  end

  let(:specific_exception) { ActionController::InvalidAuthenticityToken.new('Test Exception Message') }
  let(:submitter) { FactoryBot.create(:submitter) }
  let(:submitter_session) { { submitter_id: submitter.id } }
  let(:admin_session) { { admin: true } }

  before do
    routes.draw { get 'index' => 'anonymous#index' }
    allow(controller).to receive(:index).and_raise(specific_exception)
  end
    
  context 'as a submitter' do
    let(:session) { submitter_session }

    it 'logs the exception to the Rails logger' do
      allow(Rails.logger).to receive(:warn)
      get :index, session: session
      expect(Rails.logger).to have_received(:warn).with("InvalidAuthenticityToken occurred: Test Exception Message")
    end

    it 'resets the session' do
      get :index, session: session
      expect(session[:admin]).to be_nil
      expect(session[:submitter_id]).to be_nil
    end

    it 'sets a flash message and redirects to the root path' do
      get :index, session: session
      expect(response.status).to eq(302)
      expect(response).to redirect_to(root_path)
      expect(flash[:danger]).to eq('Your session has expired. Please log in again.')
    end
  end

  context 'as an admin' do
    let(:session) { admin_session }

    it 'logs the exception to the Rails logger' do
      allow(Rails.logger).to receive(:warn)
      get :index, session: session
      expect(Rails.logger).to have_received(:warn).with("InvalidAuthenticityToken occurred: Test Exception Message")
    end

    it 'resets the session' do
      get :index, session: session
      expect(session[:admin]).to be_nil
      expect(session[:submitter_id]).to be_nil
    end

    it 'sets a flash message and redirects to the manage path' do
      get :index, session: session
      expect(response.status).to eq(302)
      expect(response).to redirect_to(manage_path)
      expect(flash[:danger]).to eq('Your session has expired. Please log in again.')
    end
  end
end
