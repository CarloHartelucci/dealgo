class AddMerchantCodeToMerchants < ActiveRecord::Migration
  def change
  	add_column :merchants, :merchant_code, :string
  	add_index :merchants, :merchant_code
  end
end
