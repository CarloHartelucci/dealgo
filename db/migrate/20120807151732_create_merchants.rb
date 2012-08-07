class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :name
      t.string :website
      t.string :twitter
      t.string :facebook

      t.timestamps
    end
  end
end
