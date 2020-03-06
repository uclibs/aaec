# frozen_string_literal: true

class PublicPerformancesController < PublicationsController
  # Never trust parameters from the scary internet, only allow the white list through.
  def allowed_params
    params.require(:public_performance).permit(:uc_department, :other_college, :work_title, :other_title, :location, :time, :date, :submitter_id, author_first_name: [], author_last_name: [], college_ids: [])
  end
  helper_method :allowed_params
end
