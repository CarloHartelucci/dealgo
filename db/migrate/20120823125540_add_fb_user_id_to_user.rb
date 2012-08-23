class AddFbUserIdToUser < ActiveRecord::Migration
  def change
  	add_column :users, :fb_user_id, :string
  	add_index :users, :fb_user_id
  end
end
