class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.references :listing, foreign_key: true
      t.index :id
      t.timestamps
    end
  end
end
