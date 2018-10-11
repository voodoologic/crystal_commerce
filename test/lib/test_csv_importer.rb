require 'minitest/spec'
require 'test_helper'
describe CSVImporter do

  it 'test class exists' do
    assert(CSVImporter)
  end

  it 'takes csv formatted files' do
    rand_store_id = generate_csv_file
    file          = open_test_file(rand_store_id)
    csv_importer  = CSVImporter.new(file)
    csv_importer.process
  end
end

def generate_csv_file
  random_product_id = rand(1..5000)
  random_price = (rand * rand(1..100)).round(2)
  random_store_id = ['12345', '2', '4'].sample
  File.open("#{random_store_id}.csv", 'a+') do |f|
    f.write "#{random_product_id}, $#{random_price}, #{random_condition}\n"
  end
  random_store_id
end

def open_test_file(store_id)
  File.open("#{store_id}.csv")
end

def random_condition
  ['mint', 'near mint', 'very fine', 'fine', 'very good', 'good', 'fair', 'poor', 'incomplete'].sample
end

