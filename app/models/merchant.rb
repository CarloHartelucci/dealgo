class Merchant < ActiveRecord::Base
  attr_accessible :facebook, :name, :twitter, :website, :support_email, :merchant_code
  has_many :deals
  before_create :before_create

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

  protected
    def before_create
      self.merchant_code = self.name.downcase.gsub(" ", "_")
    end
  				   
end
