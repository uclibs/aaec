# frozen_string_literal: true

# ApplicationMailer Class
# ========================
#
# The ApplicationMailer serves as the base class for all other mailers in the application.
# It sets default settings that are common to all mailers. For instance, it sets the default
# sender email address.
#
# Inherited From:
# - ActionMailer::Base: Inherits all the functionalities provided by ActionMailer.
#
# Constants:
# - None
#
# Methods:
# - None (Methods would be specific to individual mailers inheriting from this class)
#
# Environment Variables:
# - MAIL_SENDER: The default "from" email address.
#
# Example Usage:
# ```
# class MyMailer < ApplicationMailer
#   def welcome_email(user)
#     @user = user
#     mail(to: @user.email, subject: 'Welcome to My Site')
#   end
# end
# ```
#
# Note: Each specific mailer should inherit from this class to utilize the default settings.

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('MAIL_SENDER')
  layout 'mailer'
end
