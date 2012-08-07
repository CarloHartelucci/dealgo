class PaymentInfo < ActiveRecord::Base
  attr_accessible :card_number, :card_type, :expiration_month, :expiration_year, :purchaser_id
  belongs_to :purchaser

  validate :card_type, presence: true,
  					   inclusion: [ 'VISA', 'AMEX', 'MC']
  validate :card_number, presence: true,
  						 length: { maximum: 20 }
  validate :expiration_month, presence: true,
  							  inclusion: [1..12]
  validate :expiration_year, presence: true,
  							 inclusion: [DateTime.now.year..2020]
end
