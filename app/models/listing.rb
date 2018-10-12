class Listing < ApplicationRecord
  belongs_to :product
  belongs_to :store, dependent: :destroy
  before_validation :format_price_string
  validates :price, presence: true

  def format_price_string
    self.price = price.gsub('$', '').strip #code from my old CSV
  end

end
