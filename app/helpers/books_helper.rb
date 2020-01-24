# frozen_string_literal: true

module BooksHelper
  def find_books(id)
    Array.wrap(Book.where(submitter_id: id))
  end
end
