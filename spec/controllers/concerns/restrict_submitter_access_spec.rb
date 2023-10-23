# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RestrictSubmitterAccess, type: :concern do
  let(:dummy_class) do
    Class.new(ApplicationController) do
      include RestrictSubmitterAccess
    end
  end

  let(:controller) { dummy_class.new }
  let(:submitter) { create(:submitter) }
  let(:another_submitter) { create(:submitter) }
  let(:book) { create(:book, submitter_id: submitter.id) }

  before do
    allow(controller).to receive(:params).and_return(id: book.id)
    allow(controller).to receive(:controller_name).and_return('some_resources')
  end

  describe '#restrict_submitter_access' do
    context 'when admin is logged in' do
      it 'does not restrict access' do
        allow(controller).to receive(:session).and_return(admin: true)
        expect(controller).not_to receive(:unauthorized_access)
        controller.restrict_submitter_access
      end
    end

    context 'when submitter is logged in' do
      before do
        allow(controller).to receive(:session).and_return(submitter_id: submitter.id)
      end

      it 'allows access if submitter owns the resource' do
        expect(controller).not_to receive(:unauthorized_access)
        controller.restrict_submitter_access
      end

      it 'denies access if submitter does not own the resource' do
        allow(controller).to receive(:params).and_return(id: create(:some_resource, submitter_id: another_submitter.id).id)
        expect(controller).to receive(:unauthorized_access)
        controller.restrict_submitter_access
      end
    end

    context 'when no one is logged in' do
      it 'denies access' do
        allow(controller).to receive(:session).and_return({})
        expect(controller).to receive(:unauthorized_access)
        controller.restrict_submitter_access
      end
    end

    context 'when in SubmittersController' do
      before do
        allow(controller).to receive(:controller_name).and_return('submitters')
        allow(controller).to receive(:params).and_return(id: submitter.id)
      end

      it 'allows access for the submitter viewing their own page' do
        allow(controller).to receive(:session).and_return(submitter_id: submitter.id)
        expect(controller).not_to receive(:unauthorized_access)
        controller.restrict_submitter_access
      end

      it 'denies access for a submitter viewing someone else’s page' do
        allow(controller).to receive(:session).and_return(submitter_id: another_submitter.id)
        expect(controller).to receive(:unauthorized_access)
        controller.restrict_submitter_access
      end
    end
  end
end
