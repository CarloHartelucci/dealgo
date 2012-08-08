class AddBasePriceToDeal < ActiveRecord::Migration
  def change
  	add_column :deals, :base_price, :decimal
  end
end
