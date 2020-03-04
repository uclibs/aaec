# frozen_string_literal: true

module BookChaptersHelper
  def find_book_chapters(id)
    Array.wrap(BookChapter.where(submitter_id: id))
  end
end
