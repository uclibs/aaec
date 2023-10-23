# frozen_string_literal: true

RSpec.shared_examples 'a publication with index action' do |model_name|
  describe 'GET #index' do
    before { login_as_submitter_of(model_name) }

    it 'returns a success response' do
      get :index
      expect(response).to be_successful
      expect(response).to redirect_to('/publications')
    end
  end
end
