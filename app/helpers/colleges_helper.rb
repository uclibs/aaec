# frozen_string_literal: true

module CollegesHelper
  def college_name(id)
    College.find(id).name
  end
end
