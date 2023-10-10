# frozen_string_literal: true

class PublicationMailer < ApplicationMailer
  helper MailerHelper
  default from: -> { ENV.fetch('MAIL_SENDER', nil) }

  def publication_submit(submitter, publication)
    @submitter = submitter
    @publication = publication
    receivers = "#{submitter.email_address}, #{ENV.fetch('MAIL_SENDER', nil)}"
    mail(to: receivers, subject: 'Publication received for Artists, Authors, Editors & Composers')
  end
end
