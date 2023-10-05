# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicationMailer, type: :mailer do
  describe 'submission' do
    let(:submitter) { FactoryBot.create(:submitter) }
    let(:mock_mail_sender) { "Joe Smith <test@test.com>" }

    before do
      # Stub the environment variable to always return the mock_mail_sender value
      allow(ENV).to receive(:fetch).with('MAIL_SENDER', nil).and_return(mock_mail_sender)
    end

    it 'sends an email for a book' do
      book = FactoryBot.create(:book)
      mail = described_class.publication_submit(submitter, book).deliver_now
      default_sender = mock_mail_sender[/<(.*?)>/, 1] # Extract email address from mock_mail_sender
      expect(mail.subject).to eq('Publication received for Artists, Authors, Editors & Composers')
      expect(mail.to).to eq([submitter.email_address, default_sender])
      expect(mail.from).to eq([default_sender])
      expect(mail.body.encoded).to match(book.work_title)
      expect(mail.body.encoded).to match("More information about this year's event is forthcoming")
      expect(mail.body.encoded).to include('<html>').once
      expect(mail.body.encoded).to include('<head>').once
      expect(mail.body.encoded).to include('<body>').once
      expect(mail.body.encoded).to include('<!DOCTYPE html>').once
    end
  end
end
