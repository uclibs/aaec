# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a publication with destroy action' do |model_name|
  let(:new_instance) { FactoryBot.create(model_name) }

  describe 'DELETE #destroy' do
    before { login_as_submitter_of(new_instance) }

    it 'destroys the requested publication' do
      expect do
        delete :destroy, params: { id: new_instance.to_param }
      end.to change(model_name.to_s.classify.constantize, :count).by(-1)
      expect(response).to redirect_to(publications_url)
      expect(flash[:warning]).to be_present
    end
  end
end
