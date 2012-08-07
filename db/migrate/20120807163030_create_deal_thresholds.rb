class CreateDealThresholds < ActiveRecord::Migration
  def change
    create_table :deal_thresholds do |t|
      t.integer :quantity
      t.decimal :price
      t.integer :deal_id
      
      t.timestamps
    end

    add_index :deal_thresholds, :deal_id
  end
end
