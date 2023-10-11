# frozen_string_literal: true

# MailerHelper Module
# ====================
#
# The MailerHelper module provides utility methods to assist in email generation.
# It includes functionalities from PublicationsHelper to create a list of author names
# formatted as a single string.
#
# Included Modules:
# - PublicationsHelper: Provides helper methods for dealing with publications.
#
# Methods:
# - all_authors_email(publication): Returns a comma-separated string of all authors'
#   names associated with a given publication.
#
# Example Usage:
# ```
# publication = Publication.find(1)
# authors_string = all_authors_email(publication)
# ```
#
# Note: This helper is intended to be used within the context of Rails' ActionMailer.

module MailerHelper
  include PublicationsHelper

  # Returns a comma-separated string of all authors' names associated with the given publication.
  #
  # @param publication [Publication] The publication whose authors' names are to be returned.
  # @return [String] A comma-separated string of author names.
  def all_authors_email(publication)
    return '' if publication.blank? || publication.author_first_name.nil? || publication.author_last_name.nil?

    author_list = ''
    size = [0, (publication.author_first_name.count - 1)].max
    (0..size).each do |i|
      author_list += author_name(publication, i)
      author_list += ', ' if i != size
    end
    author_list
  end
end
