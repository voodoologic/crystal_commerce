class CsvImporterController < ApplicationController
  def index

  end

  def upload
    upload= upload_params[:csv]
    file = File.open(upload)
    csv_importer = CSVImporter.new(file)
    csv_importer.process
    flash[:notice] = 'Successfully processed csv'
    redirect_to action: :index
  end

  private 

  def upload_params
    params.permit(:csv)
  end

end
