class DealThreshold < ActiveRecord::Base
  attr_accessible :discount, :quantity, :deal_id
  belongs_to :deal

  validate :discount, presence: true
  validate :quantity, presence: true
  validate :deal_id, presence: true

  def discount_price
  	return (100 - Float(self.discount))/100 * self.deal.base_price
  end
end
