class Merchant < ActiveRecord::Base
  attr_accessible :facebook, :name, :twitter, :website, :support_email
  has_many :deals

  validates :facebook, presence: true,
  					   length: { maximum: 200 }
  validates :twitter, presence: true,
  					  length: { maximum: 50 }
  validates :name, presence: true,
  				   length: { maximum: 100 },
  				   uniqueness: true
  validates :website, presence: true,
  				   length: { maximum: 200 }
  validates :support_email, presence: true,
             length: { maximum: 50 }
  				   
end
