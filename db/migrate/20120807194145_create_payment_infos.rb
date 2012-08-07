class CreatePaymentInfos < ActiveRecord::Migration
  def change
    create_table :payment_infos do |t|
      t.string :card_number
      t.integer :expiration_month
      t.integer :expiration_year
      t.string :card_type
      t.integer :purchaser_id
      
      t.timestamps
    end
    add_index :payment_infos, :purchaser_id
  end
end
