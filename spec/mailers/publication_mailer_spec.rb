# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicationMailer, type: :mailer do
  describe 'submission' do
    let(:submitter) { FactoryBot.create(:submitter) }

    it 'sends an email for a book' do
      book = FactoryBot.create(:book)
      mail = described_class.publication_submit(submitter, book).deliver_now
      expect(mail.subject).to eq('Publication received for Artists, Authors, Editors & Composers')
      expect(mail.to).to eq([submitter.email_address, ENV['MAIL_SENDER']])
      expect(mail.from).to eq([ENV['MAIL_SENDER']])
      expect(mail.body.encoded).to match(book.work_title)
      expect(mail.body.encoded).to match('More information about the event is forthcoming')
    end
  end
end
