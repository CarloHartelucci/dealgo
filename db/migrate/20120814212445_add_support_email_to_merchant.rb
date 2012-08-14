class AddSupportEmailToMerchant < ActiveRecord::Migration
  def change
  	add_column :merchants, :support_email, :string
  end
end
