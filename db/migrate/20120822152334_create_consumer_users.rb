class CreateConsumerUsers < ActiveRecord::Migration
  def change
    create_table :consumer_users do |t|

      t.timestamps
    end
  end
end
