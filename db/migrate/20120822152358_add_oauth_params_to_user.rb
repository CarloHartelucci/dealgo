class AddOauthParamsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :access_token, :string
  	add_column :users, :access_token_expiration, :string

  	add_index :users, :access_token
  end
end
