# frozen_string_literal: true

class PublicationMailer < ApplicationMailer
  helper MailerHelper
  default from: ENV['MAIL_SENDER']

  def publication_submit(submitter, publication)
    @submitter = submitter
    @publication = publication
    mail(to: submitter.email_address, subject: 'AAEC - Publication received')
  end
end
