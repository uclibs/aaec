# frozen_string_literal: true

# PublicationMailer
# =================
# This mailer class is responsible for sending email notifications related to
# publications. It extends the ApplicationMailer, inheriting its default settings, and
# utilizes the MailerHelper for additional utility functions.
#
# Responsibilities:
# - Send confirmation email notifications when a publication is submitted.
# - Derive the sender's email and name from an environment variable, ensuring it's formatted correctly.
#
# Usage:
# Call the `publication_submit` method, providing it with the submitter and the publication.
# This sends an email to the submitter confirming the submission of their publication.
# The email also gets BCC'd to the default sender email for tracking purposes.
#
# Example:
# ```
# PublicationMailer.publication_submit(submitter, publication).deliver_now
# ```
#
# Environment Variables:
# - MAIL_SENDER: Contains the default sender's email address (and optionally the sender's name).

class PublicationMailer < ApplicationMailer
  helper MailerHelper

  SUBJECT = 'Publication received for Artists, Authors, Editors & Composers'

  def publication_submit(submitter, publication)
    @submitter = submitter
    @publication = publication
    sender_name, sender_email = parse_default_sender
    submitter_name = "#{submitter.first_name} #{submitter.last_name}"

    mail(
      to: email_address_with_name(@submitter.email_address, submitter_name),
      bcc: sender_email,
      from: email_address_with_name(sender_email, sender_name),
      subject: SUBJECT
    )
  end

  private

  def parse_default_sender
    default_sender = ENV.fetch('MAIL_SENDER')
    raise ArgumentError, 'SMTP From address may not be blank' if default_sender.blank?

    match_data = default_sender.match(/(.+?) <(.+)>/)
    if match_data
      [match_data[1], match_data[2]] # [sender_name, sender_email]
    else
      ['', default_sender]
    end
  end
end
