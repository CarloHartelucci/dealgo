class AddMerchantIdIndexToMerchantUsers < ActiveRecord::Migration
  def change
  	add_index :merchant_users, :merchant_id
  end
end
