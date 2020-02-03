# frozen_string_literal: true

module MailerHelper
  include PublicationsHelper
  def all_authors_email(publication)
    author_list = ''
    size = [0, (publication.author_first_name.count - 1)].max
    (0..size).each do |i|
      author_list += author_name(publication, i)
      author_list += ', ' if i != size
    end
    author_list
  end
end
