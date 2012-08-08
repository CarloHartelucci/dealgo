class Deal < ActiveRecord::Base
  attr_accessible :maxquantity, :dealend, :name, :dealstart, :merchant_id, :description, :base_price
  belongs_to :merchant
  has_many :deal_thresholds
  has_many :purchases

  validate :maxquantity, presence: true
  validate :dealend, presence: true
  validate :dealstart, presence: true
  validate :base_price, presence: true

  def quantity_sold
  	self.purchases.sum(:quantity)
  end

  def current_discount
  	self.deal_thresholds.minimum(:discount, conditions: ["quantity <= ?", quantity_sold ])
  end

  def closed?
  	false unless self.dealend < DateTime.now || quantity_sold == :maxquantity else true
  end

end
