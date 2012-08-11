class AddConfirmationHashToPurchase < ActiveRecord::Migration
  def change
  	add_column :purchases, :purchase_code, :string
  	add_index :purchases, :purchase_code
  end
end
