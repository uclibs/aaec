# frozen_string_literal: true

RSpec.shared_examples 'a publication with index action' do |model_name|
  let(:first_submitter) { FactoryBot.create(:submitter) }
  let(:other_submitter) { FactoryBot.create(:submitter) }
  let(:first_publication) { FactoryBot.create(model_name, submitter_id: first_submitter.id) }
  let(:other_publication) { FactoryBot.create(model_name, submitter_id: other_submitter.id) }

  before do
    first_publication
    other_publication
  end

  context 'as a submitter' do
    before do
      login_as_submitter_of(first_publication)
    end

    it "returns an index with only that submitter's publications" do
      get :index
      expect(response).to redirect_to('/publications')
      expect(assigns(model_name.to_s.pluralize.to_sym)).to include(first_publication)
      expect(assigns(model_name.to_s.pluralize.to_sym)).not_to include(other_publication)
    end
  end

  context 'as an admin' do
    before do
      session[:admin] = true
    end

    context 'with id parameter' do
      before do
        allow(controller).to receive(:load_single_submitter_resources_for_admin).and_call_original
      end

      it 'calls load_single_submitter_resources_for_admin' do
        get :index, params: { id: first_submitter.id }
        expect(controller).to have_received(:load_single_submitter_resources_for_admin).with(first_submitter.id.to_s)
      end

      it 'returns a success response with only that submitters publications' do
        get :index, params: { id: first_submitter.id }
        expect(response).to redirect_to('/publications')
        expect(assigns(model_name.to_s.pluralize.to_sym)).to eq([first_publication])

        expect(assigns(model_name.to_s.pluralize.to_sym)).to include(first_publication)
        expect(assigns(model_name.to_s.pluralize.to_sym)).not_to include(other_publication)
      end
    end

    context 'without an id parameter' do
      it 'sets the pagy variable for the resource' do
        get(:index, session:)

        controller_pagy_variable = assigns("pagy_#{model_name}".to_sym)
        expect(controller_pagy_variable).not_to be_nil
      end

      it 'returns a success response with all submitters publications' do
        get(:index, session:)
        expect(response).to redirect_to('/publications')
        expect(assigns(model_name.to_s.pluralize.to_sym)).to include(first_publication)
        expect(assigns(model_name.to_s.pluralize.to_sym)).to include(other_publication)
      end
    end
  end

  context 'when there is an error' do
    before { session[:admin] = true }

    context 'with unauthorized path' do
      it 'redirects to publications_path' do
        get(:index, params: { path: 'unauthorized_path' }, session:)
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'when the error is a StandardError' do
      it 'raises a RoutingError, logs the error, and returns a 404 status' do
        allow(controller).to receive(:load_admin_resources).and_raise(StandardError.new('A standard error'))
        expect(Rails.logger).to receive(:error).with('Failed to load resources: A standard error')

        expect { get(:index, session:) }.to raise_error(ActionController::RoutingError, 'Not Found')
      end
    end

    context 'when the error is a NameError' do
      it 'raises a RoutingError, logs the error, and returns a 404 status' do
        allow(controller).to receive(:load_admin_resources).and_raise(NameError.new('A name error'))
        expect(Rails.logger).to receive(:error).with('Invalid resource name: A name error')

        expect { get(:index, session: { admin: true }) }.to raise_error(ActionController::RoutingError, 'Not Found')
      end
    end
  end
end
