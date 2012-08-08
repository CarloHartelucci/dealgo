class CreateCreditCardTypes < ActiveRecord::Migration
  def change
    create_table :credit_card_types do |t|
      t.string :card_type
      t.string :card_description

      t.timestamps
    end
  end
end
