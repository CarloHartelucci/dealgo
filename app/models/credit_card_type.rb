class CreditCardType < ActiveRecord::Base
  attr_accessible :card_description, :card_type

  validates :card_description, presence: true
  validates :card_type, presence: true
end
