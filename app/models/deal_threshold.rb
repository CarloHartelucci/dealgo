class DealThreshold < ActiveRecord::Base
  attr_accessible :discount, :quantity, :deal_id
  belongs_to :deal

  validates :discount, presence: true
  validates :quantity, presence: true
  validates :deal_id, presence: true

  def discount_price
  	return (100 - Float(self.discount))/100 * self.deal.base_price
  end

  default_scope :order => "deal_thresholds.quantity ASC"
end
