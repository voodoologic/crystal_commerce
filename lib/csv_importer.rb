# CSVImporter handles uploaded csv files and converts them into listings
# params: csv_file, type: File
# csv filename must be that of a store id
# columns as product_id, price, condition
require 'numbers_in_words'
require 'csv'
class CSVImporter
  attr_reader :csv_file
  def initialize(csv_file)
    @csv_file = csv_file
    @store    = fetch_store_from_csv
  end

  def process
    CSV.parse(@csv_file.read, headers: true, col_sep: "\t" ) do |listing_row|
      #Protective block 
      #Do not save anything to the database that contains errors
      #Possible to add a error handler on after_rollback callback
      begin
        ActiveRecord::Base.transaction do
          listing_from_row(listing_row)
        end
      rescue
        #Add a log waringing area here
        next
      end
    end
  end

  private

  def fetch_store_from_csv
    store_id = get_store_number
    store    = Store.where(id: store_id).first_or_initialize
    store.save! if store.new_record?
    store
  end

  def listing_from_row(listing_row)
    product_id = listing_row['hive_product_id'].to_i
    p = Product.where(id: product_id ).first_or_initialize
    p.save! if p.new_record?
    listing = Listing.new
    listing.store = @store
    listing.price = listing_row['sell_price'].gsub('$', '') # this is also done in Model
    listing.product = p
    listing.save!
  end

  def get_store_number
    NumbersInWords.in_numbers(File.basename(@csv_file.original_filename, '.*')) #could do more defensive code here
  end

end

