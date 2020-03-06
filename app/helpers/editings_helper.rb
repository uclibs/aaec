# frozen_string_literal: true

module EditingsHelper
  def find_editings(id)
    Array.wrap(Editing.where(submitter_id: id))
  end
end
