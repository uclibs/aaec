# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RestrictSubmitterAccess, type: :concern do
  let(:dummy_class) do
    Class.new(ApplicationController) do
      include RestrictSubmitterAccess
    end
  end

  let(:controller) { dummy_class.new }
  let(:submitter) { FactoryBot.create(:submitter) }
  let(:another_submitter) { FactoryBot.create(:submitter) }
  let(:book) { FactoryBot.create(:book, submitter:) }

  before do
    allow(controller).to receive(:params).and_return(id: book.id)
    allow(controller).to receive(:controller_name).and_return('books')
  end

  describe '#restrict_submitter_access' do
    context 'when admin is logged in' do
      it 'does not restrict access' do
        allow(controller).to receive(:session).and_return(admin: true)
        expect(controller).not_to receive(:unauthorized_access)

        expect { controller.send(:restrict_submitter_access) }.not_to raise_error
      end
    end

    context 'when submitter owns the resource' do
      it 'does not restrict access' do
        allow(controller).to receive(:session).and_return(submitter_id: submitter.id)
        expect(controller).not_to receive(:unauthorized_access)

        expect { controller.send(:restrict_submitter_access) }.not_to raise_error
      end
    end

    context 'when submitter does not own the resource' do
      it 'restricts access' do
        # Make sure another_submitter and book have different submitter_id
        expect(another_submitter.id).not_to eq(book.submitter_id)

        allow(controller).to receive(:params).and_return(id: book.id)
        allow(controller).to receive(:controller_name).and_return('books')
        allow(controller).to receive(:session).and_return(submitter_id: another_submitter.id)

        expect { controller.send(:restrict_submitter_access) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when controller is in the whitelist' do
      # Make sure restrict_submitter_access method behaves correctly
      # when the controller is 'errors' (or by implication, 'pages').
      it 'does not restrict access' do
        fake_session = {}
        allow(controller).to receive(:session).and_return(fake_session)

        allow(controller).to receive(:controller_name).and_return('errors')
        expect(controller).not_to receive(:unauthorized_access)
        expect { controller.send(:restrict_submitter_access) }.not_to raise_error
      end
    end

    context 'when resource does not have submitter_id attribute' do
      let(:resource_without_submitter_id) { double('Resource', submitter_id: nil) }

      it 'does not restrict access' do
        fake_session = {}
        allow(controller).to receive(:session).and_return(fake_session)

        allow(controller).to receive(:resource_has_submitter_id?).and_return(false)
        expect(controller).not_to receive(:unauthorized_access)
        expect { controller.send(:restrict_submitter_access) }.not_to raise_error
      end
    end

    context 'when dealing with SubmittersController' do
      before do
        allow(controller).to receive(:controller_name).and_return('submitters')
      end

      it 'restricts access if logged-in submitter is not the resource owner' do
        allow(controller).to receive(:params).and_return(id: submitter.id)
        allow(controller).to receive(:session).and_return(submitter_id: another_submitter.id)

        expect { controller.send(:restrict_submitter_access) }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'does not restrict access if logged-in submitter is the resource owner' do
        allow(controller).to receive(:params).and_return(id: submitter.id)
        allow(controller).to receive(:session).and_return(submitter_id: submitter.id)

        expect { controller.send(:restrict_submitter_access) }.not_to raise_error
      end
    end
  end
end
