class MoveMerchantIdToUser < ActiveRecord::Migration
  def up
  	remove_index :merchant_users, :merchant_id
  	remove_column :merchant_users, :merchant_id
  	add_column :users, :merchant_id, :integer
  end

  def down
  end
end
