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

  def create_purchase params
    errors = []
    purchaser = Purchaser.new(firstname: params[:first_name],
                   lastname: params[:last_name],
                   email: params[:email],
                   phone: params[:phone])
    if !purchaser.save
      purchaser.errors.full_messages.each do |msg|
        errors << msg
      end
    end

    payment_info = PaymentInfo.new(purchaser_id: purchaser.id,
                     card_number: params[:card_number],
                     card_type: params[:card_type],
                     expiration_month: params[:expiration_month],
                     expiration_year: params[:expiration_year])
    if !payment_info.save
      payment_info.errors.full_messages.each do |msg|
        errors << msg
      end
    end


    purchase = Purchase.new(purchaser_id: purchaser.id,
                 quantity: Integer(params[:quantity]),
                 purchased_at: DateTime.now,
                 deal_id: self.id)
    if !purchase.save
      purchase.errors.full_messages.each do |msg|
        errors << msg
      end
    end

    if errors.count > 0
      purchaser.delete
      payment_info.delete
      purchase.delete
    end

    return errors, purchase.purchase_code
  end

end
