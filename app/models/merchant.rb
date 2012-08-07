class Merchant < ActiveRecord::Base
  attr_accessible :facebook, :name, :twitter, :website
  has_many :deals

  validate :facebook, presence: true,
  					   length: { maximum: 200 }
  validate :twitter, presence: true,
  					  length: { maximum: 50 }
  validate :name, presence: true,
  				   length: { maximum: 100 },
  				   uniqueness: true
  validate :website, presence: true,
  				   length: { maximum: 200 }
  				   
end
