# frozen_string_literal: true

class AdminController < ApplicationController
  skip_before_action :check_date

  ALLOWED_CONTROLLERS_TO_MODELS = {
    'artworks' => Artwork,
    'books' => Book,
    'book_chapters' => BookChapter,
    'digital_projects' => DigitalProject,
    'editings' => Editing,
    'films' => Film,
    'journal_articles' => JournalArticle,
    'musical_scores' => MusicalScore,
    'photographies' => Photography,
    'physical_media' => PhysicalMedium,
    'plays' => Play,
    'public_performances' => PublicPerformance,
    'submitters' => Submitter,
    'other_publications' => OtherPublication
  }.freeze

  def login; end

  def validate
    if check_credentials(params[:username], params[:password])
      session[:admin] = true
      redirect_to publications_path
    else
      redirect_to manage_path, notice: 'Invalid Credentails'
    end
  end

  def csv
    if session[:admin] && params[:id].nil? && allowed_model
      begin
        @instance_variable = allowed_model.all
        respond_to do |format|
          format.html { redirect_to publications_path }
          format.csv { send_data @instance_variable.to_csv }
        end
      rescue StandardError => e
        logger.error "CSV generation failed: #{e}"
        flash.keep[:danger] = 'Something went wrong while generating the CSV.'
        redirect_to publications_path
      end
    else
      redirect_to publications_path
    end
  end

  def citations
    if session[:admin]
      all = fetch_all_records
      @college_array = []
      (1..College.count).each do |i|
        @college_array << [i, all.select { |p| p.respond_to?(:college_ids) && p.college_ids.include?(i) }.group_by(&:uc_department)]
      end
    else
      redirect_to publications_path
    end
  end

  def toggle_links
    session[:links] = session[:links] == false
    redirect_to citations_path
  end

  private

  def check_credentials(username, password)
    username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
  end

  def allowed_model
    ALLOWED_CONTROLLERS_TO_MODELS[params[:controller_name]]
  end

  def fetch_all_records
    all_records = []
    ALLOWED_CONTROLLERS_TO_MODELS.each_value do |model|
      all_records += model.all
    end
    all_records
  end
end
