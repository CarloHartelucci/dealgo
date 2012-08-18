class AddColorsToMerchant < ActiveRecord::Migration
  def change
  	add_column :merchants, :primary_color, :string
  	add_column :merchants, :secondary_color, :string
  end
end
