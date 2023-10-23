# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'publication with destroy action' do |model_name|
  describe 'DELETE #destroy' do
    before { login_as_submitter_of(model_name) }

    it 'destroys the requested publication' do
      expect do
        delete :destroy, params: { id: model_name.to_param }
      end.to change(model_name, :count).by(-1)
      expect(response).to redirect_to(publications_url)
      expect flash[:warning].to be_present
    end
  end
end
