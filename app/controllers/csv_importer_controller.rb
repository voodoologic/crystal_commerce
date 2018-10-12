class CsvImporterController < ApplicationController
  def index

  end

  def upload
    upload= upload_params[:csv] #it's possible to have multiple files, but I didn't do that
    csv_importer = CSVImporter.new(upload)
    csv_importer.process
    # background process scraped for time
    # ProcessCsvJob.perform_later(upload)
    flash[:notice] = 'Successfully processed csv'
    redirect_to action: :index
  end

  private

  def upload_params
    params.permit(:csv)
  end

end
