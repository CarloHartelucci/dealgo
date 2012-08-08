class RenamePriceToDiscountOnDealThreshold < ActiveRecord::Migration
  def up
  	change_table :deal_thresholds do |t|
	  	t.column :discount, :integer
	  	t.remove :price
  	end
  end

  def down
  	  	change_table :deal_thresholds do |t|
	  	t.column :price, :decima;
	  	t.remove :discount
  	end
  end
end
