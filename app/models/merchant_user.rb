class MerchantUser < User
  attr_accessible :merchant_id
  belongs_to :merchant
end
