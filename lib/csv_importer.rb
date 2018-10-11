require 'csv'
class CSVImporter
  attr_reader :csv_file
  def initialize(csv_file)
    @csv_file = csv_file
    @store    = fetch_store_from_csv
  end

  def process
    csv = CSV.open @csv_file
    csv.each do |listing_row|
      listing_from_row(listing_row)
    end
  end

  private

  def fetch_store_from_csv
    store_id = File.basename(@csv_file, '.*')
    store    = Store.where(id: store_id).first_or_initialize
    store.save! if store.new_record?
    store
  end

  def listing_from_row(listing_row)
    p = Product.where(id: listing_row[0]).first_or_initialize
    p.save! if p.new_record?
    listing = Listing.new
    listing.store = @store
    listing.product = p
    listing.save!
    listing
  end

end

