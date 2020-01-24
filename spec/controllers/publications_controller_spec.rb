# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicationsController, type: :controller do
  let(:valid_session) { { submitter_id: 1 } }

  describe 'GET #index' do
    before do
      Submitter.create!(
        first_name: 'First Name',
        last_name: 'Last Name',
        college: 2,
        department: 'Department',
        mailing_address: 'Mailing Address',
        phone_number: '111-111-1111',
        email_address: 'test@mail.uc.edu'
      )
    end

    it 'returns a success response' do
      get :index, session: valid_session
      expect(response).to be_successful
    end
  end
end
