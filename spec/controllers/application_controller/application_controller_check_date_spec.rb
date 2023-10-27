# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  include ApplicationHelper

  controller(ApplicationController) do
    def index
      render plain: 'Hello, world!'
    end
  end

  let :submitter do
    FactoryBot.create(:submitter)
  end

  let :valid_session do
    { submitter_id: submitter.id }
  end

  describe 'before_action :check_date' do
    it 'should be called before every action' do
      expect(controller).to receive(:check_date)
      get :index, session: valid_session
    end

    context 'when EXPIRATION_DATE is in the past' do
      before do
        allow(ENV).to receive(:fetch).with('EXPIRATION_DATE').and_return('2000-01-01')
      end

      context 'and user is not admin' do
        it 'redirects to the closed page' do
          get :index
          expect(response).to redirect_to(page_route('closed'))
        end
      end

      context 'when user is admin' do
        it 'does not redirect' do
          session[:admin] = true
          get :index
          expect(response.body).to eq('Hello, world!')
        end
      end
    end

    context 'when EXPIRATION_DATE is in the future' do
      it 'does not redirect' do
        allow(ENV).to receive(:fetch).with('EXPIRATION_DATE').and_return('3000-01-01')
        get :index, session: valid_session
        expect(response.body).to eq('Hello, world!')
      end
    end

    context 'when EXPIRATION_DATE is missing' do
      it 'raises a KeyError' do
        # Stub ENV to simulate KeyError
        allow(ENV).to receive(:fetch).with('EXPIRATION_DATE').and_raise(KeyError)
        expect { get :index }.to raise_error(KeyError)
      end
    end
  end
end
