class AddNotificationOptinToPurchaser < ActiveRecord::Migration
  def change
  	add_column :purchasers, :notification_optin, :boolean
  end
end
