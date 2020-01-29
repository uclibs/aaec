# frozen_string_literal: true

FactoryBot.define do
    factory :submitter do
        first_name  { 'First' }
        last_name  { 'Last' }
        college  { '2' }
        department  { 'Department' }
        mailing_address  { 'Home Address' }
        phone_number  { '111-111-1111' }
        email_address  { 'test@mail.uc.edu' }
    end
end