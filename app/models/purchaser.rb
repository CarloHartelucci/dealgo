class Purchaser < ActiveRecord::Base
  attr_accessible :email, :firstname, :lastname, :phone
  has_many :purchases
  has_one :payment_info

  validate :email, presence: true
  validate :firstname, presence: true
  validate :lastname, presence: true
  validate :phone, presence: true
end
