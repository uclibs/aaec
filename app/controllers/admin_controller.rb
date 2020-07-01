# frozen_string_literal: true

class AdminController < ApplicationController
  skip_before_action :check_date
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
    if session[:admin] && params[:id].nil?
      instance_variable_set('@instance_variable', Object.const_get(params[:controller_name].classify).all)
      respond_to do |format|
        format.html { redirect_to publications_path }
        format.csv { send_data @instance_variable.to_csv }
      end
    else
      redirect_to publications_path
    end
  end

  def citations
    @all = Artwork.all + Book.all + BookChapter.all + DigitalProject.all + Editing.all + Film.all + JournalArticle.all + MusicalScore.all + Photography.all + PhysicalMedium.all + Play.all + PublicPerformance.all + OtherPublication.all
  end

  private

  def check_credentials(username, password)
    username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
  end
end
