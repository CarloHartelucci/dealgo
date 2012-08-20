class Add < ActiveRecord::Migration
  def up
  	add_column :merchants, :description, :string
  end

  def down
  end
end
