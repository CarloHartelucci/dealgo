class AddLogoToMerchant < ActiveRecord::Migration
  def change
  	add_column :merchants, :logo, :string
  end
end
