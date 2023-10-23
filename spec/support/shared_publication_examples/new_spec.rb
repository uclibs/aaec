# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a publication with new action' do |model_name|
  describe 'GET #new' do
    before { login_as_submitter_of(model_name) }

    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_successful
      expect(response).to render_template('create')
    end
  end
end
