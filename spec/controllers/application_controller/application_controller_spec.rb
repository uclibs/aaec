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
<<<<<<<< HEAD:spec/controllers/application_controller/application_controller_check_date_spec.rb
========

>>>>>>>> 22b3ff0 (wip, broken rescue_from):spec/controllers/application_controller/application_controller_spec.rb
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
<<<<<<<< HEAD:spec/controllers/application_controller/application_controller_check_date_spec.rb
========
        
        # Temporarily modify the behavior of rescue_from
        allow(controller).to receive(:render_500) do |error|
          raise error
        end
>>>>>>>> 22b3ff0 (wip, broken rescue_from):spec/controllers/application_controller/application_controller_spec.rb

        expect { get :index }.to raise_error(KeyError)
      end
    end
  end
end
