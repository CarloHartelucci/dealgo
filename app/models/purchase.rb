class Purchase < ActiveRecord::Base
  attr_accessible :purchased_at, :quantity, :deal_id, :purchaser_id
  belongs_to :deal
  belongs_to :purchaser

  validates :purchased_at, presence: true
  validates :quantity, presence: true
  validates :purchaser_id, presence: true
  validates :deal_id, presence: true

end
