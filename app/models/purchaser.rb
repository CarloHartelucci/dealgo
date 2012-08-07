class Purchaser < ActiveRecord::Base
  attr_accessible :email, :firstname, :lastname, :phone
  has_many :purchases

  validate :email, presence: true
  validate :firstname, presence: true
  validate :lastname, presence: true
  validate :phone, presence: true
end
