# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubmittersController, type: :controller do
  let(:submitter) { FactoryBot.create(:submitter) }
  let(:another_submitter) { FactoryBot.create(:submitter) }

  before do
    submitter
    another_submitter
  end

  # There are no Submitters index or destroy actions, so we cannot test them.
  # The SubmittersController is tested in spec/controllers/submitters_controller_spec.rb.

  describe '#submitter_owned_content_guard' do
    context 'when admin is logged in' do
      before { login_as_admin }

      it 'allows access to show' do
        get :show, params: { id: submitter.id }
        expect(response).to have_http_status(:ok)
      end

      it 'allows access to edit' do
        get :edit, params: { id: submitter.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when submitter owns the resource' do
      before { login_as_submitter_of(submitter) }

      it 'allows access to show' do
        get :show, params: { id: submitter.id }
        expect(response).to have_http_status(:ok)
      end

      it 'allows access to edit' do
        get :edit, params: { id: submitter.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when another submitter is logged in' do
      before { login_as_submitter_of(another_submitter) }

      it 'restricts access to show' do
        expect { get :show, params: { id: submitter.id } }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'restricts access to edit' do
        expect { get :edit, params: { id: submitter.id } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when no user is logged in' do
      # Not tested because this scenario is handled by the UserAuthentication concern.
    end
  end
end
