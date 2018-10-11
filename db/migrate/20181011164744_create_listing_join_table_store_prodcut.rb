class CreateListingJoinTableStoreProdcut < ActiveRecord::Migration[5.2]
  def change
    create_join_table :stores, :products, table_name: :listings do |t|
      t.index [:product_id, :store_id]
      t.bigint :id, primary_key: true
      t.string :condition, null: false
      t.string :price, null: false
      t.timestamps
    end
  end
end
