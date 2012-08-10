class Purchaser < ActiveRecord::Base
  attr_accessible :email, :firstname, :lastname, :phone, :notification_optin
  has_many :purchases
  has_one :payment_info

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
  					format: { with: VALID_EMAIL_REGEX }
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :phone, presence: true
end
