# frozen_string_literal: true

class PublicationMailer < ApplicationMailer
  helper MailerHelper
  default from: ENV['MAIL_SENDER']

  def publication_submit(submitter, publication)
    @submitter = submitter
    @publication = publication
    receivers = "#{submitter.email_address}, #{ENV['MAIL_SENDER']}"
    mail(to: receivers, subject: 'Publication received for Artists, Authors, Editors & Composers')
  end
end
