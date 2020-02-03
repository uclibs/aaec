# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicationMailer, type: :mailer do
  describe 'submission' do
    let(:submitter) { FactoryBot.create(:submitter) }

    it 'sends an email for a book' do
      book = FactoryBot.create(:book)
      mail = described_class.publication_submit(submitter, book).deliver_now
      expect(mail.subject).to eq('AAEC - Publication received')
      expect(mail.to).to eq([submitter.email_address])
      expect(mail.from).to eq([ENV['MAIL_SENDER']])
      expect(mail.body.encoded).to match(book.work_title)
      expect(mail.body.encoded).to match('Please include an address where I may return your publication')
    end
  end
end
