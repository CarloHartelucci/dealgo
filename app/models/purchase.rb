class Purchase < ActiveRecord::Base
  attr_accessible :purchased_at, :quantity, :deal_id, :purchaser_id, :purchase_code
  belongs_to :deal
  belongs_to :purchaser
  before_create :before_create

  class PurchaseValidator < ActiveModel::Validator
	def validate(record)
	  deal = Deal.find(record.deal_id)
	  if record.quantity > deal.available_quantity
	  	record.errors[:quantity] << "exceeds available quantity."
	  end
	end
  end

  validates_with PurchaseValidator

  protected
  	def before_create
  	  self.purchase_code = SecureRandom.urlsafe_base64(10)
    end
end
