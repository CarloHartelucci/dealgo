class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.datetime :dealstart
      t.datetime :dealend
      t.integer :maxquantity
      t.string :name
      t.integer :merchant_id

      t.timestamps
    end
    add_index :deals, :merchant_id
  end
end
