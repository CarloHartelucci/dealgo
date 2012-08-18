class Merchant < ActiveRecord::Base
  attr_accessible :facebook, :name, :twitter, :website, :support_email, :merchant_code, :primary_color, :secondary_color, :logo
  has_many :deals
  has_many :merchant_users
  before_create :before_create

  PRIMARY_COLOR = "blue"
  SECONDARY_COLOR = "orange"

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

  def get_primary_color
    if self.primary_color.nil?
      return PRIMARY_COLOR
    else
      return self.primary_color
    end
  end

  def get_secondary_color
    if self.secondary_color.nil?
      return SECONDARY_COLOR
    else
      return self.secondary_color
    end
  end

  protected
    def before_create
      self.merchant_code = self.name.downcase.gsub(" ", "-")
      self.twitter = "@" << self.twitter
    end
  				   
end
