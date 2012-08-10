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
  	self.deal_thresholds.minimum(:discount, conditions: ["quantity <= ?", quantity_sold ])
  end

  def closed?
  	false unless self.dealend < DateTime.now || quantity_sold == :maxquantity else true
  end

  def available_quantity
    self.maxquantity - self.quantity_sold
  end

  def quantity_available(quantity)
    true unless quantity > available_quantity else false
  end

  def create_purchase(purchaser, quantity)
    purchase = Purchase.new
    if quantity <= available_quantity 
      purchase.deal_id = self.id
      purchase.quantity = quantity
      purchase.purchaser_id = purchaser.id
    else
      purchase.errors.add(:quantity, "exceeds available quantity")
    end

    return purchase
  end
end
