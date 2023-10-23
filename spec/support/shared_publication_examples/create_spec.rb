# frozen_string_literal: true

RSpec.shared_examples 'a publication with create action' do |model_name, valid_params, invalid_params|
  describe 'POST #create' do
    before { login_as_submitter_of(publication) }

    context 'with valid params' do
      it 'creates and verifies a new Publication' do
        expect do
          post :create, params: { model_name: valid_params }
        end.to change(model_name, :count).by(1)

        created_publication = model_name.last

        expect(created_publication) do |attribute|
          expect(created_publication.send(attribute))
        end.to eql(valid_params[attribute])
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { model_name: invalid_params }
        expect(response).to be_successful
        expect(response).to render_template('new')
        expect flash[:danger].to be_present
      end
    end
  end
end
