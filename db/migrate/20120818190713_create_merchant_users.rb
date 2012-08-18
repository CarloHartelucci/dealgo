class CreateMerchantUsers < ActiveRecord::Migration
  def change
    create_table :merchant_users do |t|
      t.integer :merchant_id
      t.timestamps
    end
  end
end
