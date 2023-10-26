# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a publication with new action' do
  let(:submitter) { FactoryBot.create(:submitter) } 
  let(:valid_session) { { submitter_id: submitter.id } }

  it 'renders the :new template' do
    get :new, session: valid_session
    expect(response).to have_http_status(:success)
    expect(response).to render_template(:new)
  end
end
