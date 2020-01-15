# frozen_string_literal: true

class OtherPublicationsController < PublicationsController
  before_action :set_object, only: %i[show edit update destroy]

  # Never trust parameters from the scary internet, only allow the white list through.
  def allowed_params
    params.require(:other_publication).permit(:author_first_name, :author_last_name, :uc_department, :work_title, :other_title, :volume, :issue, :page_numbers, :publisher, :city, :publication_date, :url, :doi, :submitter_id, college_ids: [])
  end
  helper_method :allowed_params
end
