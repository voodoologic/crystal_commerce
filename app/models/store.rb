class Store < ApplicationRecord
  has_many :listings
  has_many :products, through: :listings
end
