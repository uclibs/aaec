# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a publication with show action' do |model_name|
  describe 'GET #show' do
    before { login_as_submitter_of(model_name) }

    it 'returns a success response' do
      get :show, params: { id: model_name.to_param }
      expect(response).to be_successful
      expect(response).to render_template('show')
    end
  end

  describe 'GET #show as admin' do
    before do
      session[:admin] = true
      session[:submitter_id] = nil
    end

    it 'returns a success response' do
      get :show, params: { id: publication.to_param }
      expect(response).to be_successful
      expect(response).to render_template('show')
    end
  end
end
