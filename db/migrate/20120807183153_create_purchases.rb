class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :quantity
      t.datetime :purchased_at
      t.integer :deal_id
      t.integer :purchaser_id

      t.timestamps
    end
    add_index :purchases, :deal_id
    add_index :purchases, :purchaser_id
  end
end
