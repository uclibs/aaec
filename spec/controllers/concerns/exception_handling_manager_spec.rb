# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'handles invalid authorization token' do
  it 'logs the exception to the Rails logger' do
    allow(Rails.logger).to receive(:warn)
    get :index
    expect(Rails.logger).to have_received(:warn).with("InvalidAuthenticityToken occurred: Test Exception Message")
  end

  it 'resets the session' do
    get :index
    expect(session[:admin]).to be_nil
    expect(session[:submitter_id]).to be_nil
  end

  it 'sets a flash message and redirects to the root path' do
    get :index
    expect(response.status).to eq(302)
    expect(response).to redirect_to(root_path)
    expect(flash[:danger]).to eq('Your session has expired. Please log in again.')
  end
end


RSpec.describe ExceptionHandlingManager, type: :controller do
  controller(ApplicationController) do
    include ExceptionHandlingManager

    def index
      render plain: 'Hello, world!'
    end
  end

  let(:specific_exception) { ActionController::InvalidAuthenticityToken.new('Test Exception Message') }
  let(:submitter) { FactoryBot.create(:submitter) }

  before do
    routes.draw { get 'index' => 'anonymous#index' }
  end

  describe 'handle_invalid_token' do
    context 'when an InvalidAuthenticityToken exception is raised' do
      before do
        allow(controller).to receive(:index).and_raise(specific_exception)
      end

      context 'with an admin session' do
        before do
          session[:admin] = true
        end

        it_behaves_like 'handles invalid authorization token'
      end

      context 'with a submitter session' do
        before do
          session[:submitter_id] = submitter.id
        end

        it_behaves_like 'handles invalid authorization token'
      end
    end
  end
end
  