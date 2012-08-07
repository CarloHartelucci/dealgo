class DealThreshold < ActiveRecord::Base
  attr_accessible :price, :quantity, :deal_id
  belongs_to :deal

  validate :price, presence: true
  validate :quantity, presence: true
  validate :deal_id, presence: true
end
