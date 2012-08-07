class Purchase < ActiveRecord::Base
  attr_accessible :purchased_at, :quantity, :deal_id, :purchaser_id
  belongs_to :deal
  belongs_to :purchaser

  validate :purchased_at, presence: true
  validate :quantity, presence: true
  validate :purchaser_id, presence: true
  validate :deal_id, presence: true

end
