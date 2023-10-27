# frozen_string_literal: true

RSpec.shared_examples 'a publication with create action' do |model_name, valid_params, invalid_params|
  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }
  let(:model_class) { model_name.to_s.classify.constantize }

  before do
    valid_session
  end

  describe 'POST #create' do
    context 'with valid params' do

      it "increases #{model_name} count by 1" do
        expect do
          post :create, params: { model_name => valid_params.merge({ submitter: }) }, session: valid_session
        end.to change(model_class, :count).by(1)
      end

      it "the newly created #{model_name} has the correct attributes" do
        post :create, params: { model_name => valid_params.merge({ submitter: }) }, session: valid_session
        created_publication = model_name.to_s.classify.constantize.last

        valid_params.each do |attribute, value|
          retrieved_value = created_publication.send(attribute.to_s)

          if value.is_a?(Array)
            expect(retrieved_value).to match_array(value)
          else
            expect(retrieved_value.to_s).to eql(value.to_s)
          end
        end
      end

      it "redirects to the publications page" do
        post :create, params: { model_name => valid_params.merge({ submitter: }) }, session: valid_session
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it "doesn't create #{model_name} with invalid params" do
        expect do
          post :create, params: { model_name => invalid_params.merge({ submitter_id: submitter.id }) }, session: valid_session
        end.not_to change(model_class, :count)
      end

      it "re-renders the 'new' template with a warning message" do
        post :create, params: { model_name => invalid_params.merge({ submitter_id: submitter.id }) }, format: :html, session: valid_session
        expect(response).to render_template('new')
      end

      it "displays error messages" do
        post :create, params: { model_name => invalid_params.merge({ submitter_id: submitter.id }) }, format: :json, session: valid_session
        json_response = JSON.parse(response.body)
        invalid_params.each do |attr, _value|
          if model_name.respond_to?(attr)
            expect(json_response[attr.to_s]).to be_present
          end
        end
      end
    end
  end
end
