# frozen_string_literal: true

class PublicationMailer < ApplicationMailer
  helper MailerHelper

  def publication_submit(submitter, publication)
    @submitter = submitter
    @publication = publication
    default_sender = ENV.fetch('MAIL_SENDER')
    receivers = "#{submitter.email_address}, #{default_sender}"
    mail(to: receivers, from: default_sender, subject: 'Publication received for Artists, Authors, Editors & Composers')
  end
end
