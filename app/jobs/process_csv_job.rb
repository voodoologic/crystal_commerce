# added this job to prevent post requests
# to server to retry after timeout.
# Big csv files take forever
# and we want to background them.
class ProcessCsvJob < ApplicationJob
  queue_as :default

  def perform(upload)
    csv_importer = CSVImporter.new(upload)
    # ActiveRecord::Base.transaction do could invalidate an entire run
    csv_importer.process
  end
end
