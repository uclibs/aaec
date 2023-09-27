# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  include ApplicationHelper

  controller(ApplicationController) do
    def index
      render plain: 'Hello, world!'
    end
  end

  describe 'before_action :check_date' do
    it 'should be called before every action' do
      expect(controller).to receive(:check_date)
      get :index
    end

    context 'when EXPIRATION_DATE is in the past and user is not admin' do
      it 'redirects to the closed page' do
        allow(ENV).to receive(:fetch).with('EXPIRATION_DATE').and_return('2000-01-01')
        get :index
        expect(response).to redirect_to(page_route('closed'))
      end
    end

    context 'when EXPIRATION_DATE is in the future' do
      it 'does not redirect' do
        allow(ENV).to receive(:fetch).with('EXPIRATION_DATE').and_return('3000-01-01')
        get :index
        expect(response.body).to eq('Hello, world!')
      end
    end

    context 'when user is admin' do
      it 'does not redirect' do
        session[:admin] = true
        allow(ENV).to receive(:fetch).with('EXPIRATION_DATE').and_return('2000-01-01')
        get :index
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
