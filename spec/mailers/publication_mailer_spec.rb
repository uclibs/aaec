# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicationMailer, type: :mailer do
  describe 'publication_submit' do
    let(:submitter) { FactoryBot.create(:submitter, email_address: 'submitter@example.com') }
    let(:publication) { FactoryBot.create(:book, work_title: 'Sample Title') }
    let(:mail) { described_class.publication_submit(submitter, publication).deliver_now }

    context 'when MAIL_SENDER has name and email' do
      before do
        stub_const('ENV', { 'MAIL_SENDER' => 'Sender Name <sender@example.com>' })
      end

      let(:mail) { described_class.publication_submit(submitter, publication).deliver_now }

      it 'uses the name and email in the from field' do
        expect(mail.from).to eq(['sender@example.com'])
        expect(mail[:from].display_names).to eq(['Sender Name'])
      end
    end

    context 'when MAIL_SENDER is only an email' do
      before do
        stub_const('ENV', { 'MAIL_SENDER' => 'sender@example.com' })
      end

      let(:mail) { described_class.publication_submit(submitter, publication).deliver_now }

      it 'uses just the email in the from field' do
        expect(mail.from).to eq(['sender@example.com'])
        expect(mail[:from].display_names).to eq([nil])
      end

      it 'sends the email' do
        expect { mail }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'sends to the correct recipients' do
        expect(mail.to).to eq(['submitter@example.com', 'sender@example.com'])
        expect(mail.bcc).to be_nil
      end

      it 'has the correct subject' do
        expect(mail.subject).to eq('Publication received for Artists, Authors, Editors & Composers')
      end

      it "includes the following in the body: author names, work_title,
      'More information...' sentence, and appropriate html tags" do
        publication.author_first_name.each do |first_name|
          expect(mail.body.encoded).to include(first_name)
        end
        publication.author_last_name.each do |last_name|
          expect(mail.body.encoded).to include(last_name)
        end
        expect(mail.body.encoded).to match(publication.work_title)
        expect(mail.body.encoded).to match("More information about this year's event is forthcoming")
        expect(mail.body.encoded).to include('<html>').once
        expect(mail.body.encoded).to include('<head>').once
        expect(mail.body.encoded).to include('<body>').once
        expect(mail.body.encoded).to include('<!DOCTYPE html>').once
      end
    end

    context 'when MAIL_SENDER is empty' do
      before do
        allow(ENV).to receive(:fetch).with('MAIL_SENDER', nil).and_return(nil)
      end

      it 'raises an error' do
        expect { described_class.publication_submit(submitter, publication).deliver_now }.to raise_error(ArgumentError, /SMTP From address may not be blank/)
      end
    end
  end
end
