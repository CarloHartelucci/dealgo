class CreditCardType < ActiveRecord::Base
  attr_accessible :card_description, :card_type

  validate :card_description, presence: true
  validate :card_type, presence: true
end
