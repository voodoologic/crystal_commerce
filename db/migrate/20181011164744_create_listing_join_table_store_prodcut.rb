class CreateListingJoinTableStoreProdcut < ActiveRecord::Migration[5.2]
  def change
    create_join_table :stores, :products, table_name: :listings do |t|
      t.index [:product_id, :store_id]
      t.bigint :id, primary_key: true
      t.string :condition
      t.string :price
      t.timestamps
    end
  end
end
