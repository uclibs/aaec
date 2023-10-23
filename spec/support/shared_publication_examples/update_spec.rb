# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a publication with update action' do |model_name, valid_params, invalid_params, new_params|
  describe 'PUT #update' do
    before { login_as_submitter_of(model_name) }

    context 'with valid params' do
      let(:new_attributes) do
        valid_params.merge(**new_params)
      end

      it 'updates the requested other publication' do
        put :update, params: { id: model_name.to_param, model_name: new_attributes }
        model_name.reload
        expect(new_attributes) do |param|
          expect(model_name.send(param)).to eq(new_attributes[param])
        end
        expect(response).to redirect_to(other_publication)
      end
    end

    context 'with invalid params' do
      let(:new_attributes) do
        valid_params.merge(**invalid_params)
      end
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: model_name.to_param, model_name: new_attributes }
        expect(response).to be_successful
        expect(response).to render_template('edit')
        expect flash[:danger].to be_present
      end
    end
  end
end
