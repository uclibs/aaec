# frozen_string_literal: true

# PublicationMailer Class
# ========================
#
# The PublicationMailer class is responsible for sending out emails related to
# the submissions of publications. It extends the ApplicationMailer to inherit
# the default configurations.
#
# Inherited From:
# - ApplicationMailer: Inherits default email settings from ApplicationMailer.
#
# Constants:
# - None
#
# Helpers:
# - MailerHelper: Provides utility functions to assist in constructing email content.
#
# Methods:
# - publication_submit(submitter, publication): Sends an email notification
#   when a publication is submitted.
#
# Environment Variables:
# - MAIL_SENDER: The default "from" email address, inherited from ApplicationMailer.
#
# Example Usage:
# ```
# PublicationMailer.publication_submit(submitter, publication).deliver_now
# ```
#
# Note: This mailer should only be called upon the submission of a new publication.

class PublicationMailer < ApplicationMailer
  helper MailerHelper

  # Sends a publication submission confirmation email.
  #
  # This method is responsible for sending an email notification to confirm the
  # receipt of a new publication submission. The email is sent to the submitter,
  # and a blind carbon copy (BCC) is sent to a default email address for tracking
  # purposes.
  #
  # @param [Object] submitter The entity responsible for the submission.
  #                           Must respond to 'email_address' and 'name'.
  # @param [Object] publication The publication object that has been submitted.
  # @return [Mail::Message] A Mail::Message object representing the email that will be sent.

  def publication_submit(submitter, publication)
    @submitter = submitter
    @publication = publication
    default_sender = ENV.fetch('MAIL_SENDER') || ''

    # parse out the sender name and email address
    match_data = default_sender.match(/(.+?) <(.+)>/)

    if match_data
      sender_name, sender_email = match_data.captures
    else
      sender_name = ''
      sender_email = default_sender
    end

    submitter_name = "#{submitter.first_name} #{submitter.last_name}"
    mail(to: email_address_with_name(@submitter.email_address, submitter_name), bcc: default_sender, from: email_address_with_name(sender_email, sender_name), subject: 'Publication received for Artists, Authors, Editors & Composers')
  end
end
