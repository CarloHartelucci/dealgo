class PaymentInfo < ActiveRecord::Base
  attr_accessible :card_number, :card_type, :expiration_month, :expiration_year, :purchaser_id
  belongs_to :purchaser

  VALID_CREDIT_CARD_REGEX = /[0-9]+/
  validates :card_type, presence: true,
  					    inclusion: [ 'VISA', 'AMEX', 'MC']
  validates :card_number, presence: true,
   						 length: { minimum: 16, maximum: 20 },
  						 format: { with: VALID_CREDIT_CARD_REGEX }
  validates :expiration_month, presence: true,
  							  inclusion: [1..12]
  validates :expiration_year, presence: true,
  							 inclusion: [DateTime.now.year..2020]
end
