class Deal < ActiveRecord::Base
  attr_accessible :maxquantity, :dealend, :name, :dealstart, :merchant_id, :description, :base_price
  belongs_to :merchant
  has_many :deal_thresholds
  has_many :purchases

  validates :maxquantity, presence: true
  validates :dealend, presence: true
  validates :dealstart, presence: true
  validates :base_price, presence: true

  def quantity_sold
  	self.purchases.sum(:quantity)
  end

  def current_discount
  	self.deal_thresholds.maximum(:discount, conditions: ["quantity <= ?", quantity_sold ])
  end

  def closed?
    if self.dealend < DateTime.now || quantity_sold == :maxquantity
      return true
    else
      return false
    end
  end

  def available_quantity
    self.maxquantity - self.quantity_sold
  end
end
