# frozen_string_literal: true

class AdminController < ApplicationController
  include UserAuthentication
  include CacheHeaderControl
  
  skip_before_action :require_authenticated_user, only: %i[login validate]
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
    redirect_to publications_path if params[:id] || !allowed_model

    begin
      @instance_variable = allowed_model.all
      respond_to do |format|
        format.html { redirect_to publications_path }
        format.csv { send_data @instance_variable.to_csv }
      end
    rescue StandardError => e
      logger.error "CSV generation failed: #{e}"
      redirect_to publications_path, notice: 'Something went wrong while generating the CSV.'
    end
  end

  def citations
    all = fetch_all_records
    @college_array = []
    (1..College.count).each do |i|
      @college_array << [i, all.select { |p| p.respond_to?(:college_ids) && p.college_ids.include?(i) }.group_by(&:uc_department)]
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
