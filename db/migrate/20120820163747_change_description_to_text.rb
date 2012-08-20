class ChangeDescriptionToText < ActiveRecord::Migration
  def up
  	remove_column :merchants, :description
  	add_column :merchants, :description, :text
  end

  def down
  end
end
