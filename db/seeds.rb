# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Merchant.delete_all
db =
	Merchant.create!(name:"Dirty Bird",
					 website:"http://dirtybirdnyc",
					 twitter:"@dirtybirdtogo",
					 facebook:"https://www.facebook.com/pages/Dirty-Bird-to-go/122190816732")

Deal.delete_all
deal =
	Deal.create!(:dealstart => DateTime.now, 
				 :dealend => DateTime.now + 7, 
				 :maxquantity => 100, 
				 :name => "Customer Referral Program",
				 :description => "Purchase $25 dollars at a discount up to 15% off. The more vouchers sold the deeper the discount",
				 :merchant_id => db.id)

DealThreshold.delete_all
dt1 = DealThreshold.create!(price:0.95*25, quantity:0, deal_id: deal.id)
dt2 = DealThreshold.create!(price:0.90*25, quantity:50, deal_id: deal.id)
dy3 = DealThreshold.create!(price:0.85*25, quantity:100, deal_id: deal.id)

Purchaser.delete_all
purchaser = Purchaser.create!(firstname:"Charlie", lastname:"Hartel", 
							 email:"charliehartel@yahoo.com", 
							 phone:"917-209-1280",
							 notification_optin:true)

Purchase.delete_all
purchase = Purchase.create!(quantity:1, purchased_at:DateTime.now, deal_id:deal.id, purchaser_id: purchaser.id)

PaymentInfo.delete_all
pi = PaymentInfo.create!(purchaser_id:purchaser.id, 
						 card_number:12345678987654321, card_type:"VISA",
						 expiration_month:12, expiration_year:2015)

CreditCardType.delete_all
CreditCardType.create!(card_type:"VISA", card_description:"Visa")
CreditCardType.create!(card_type:"MC", card_description:"MasterCard")
CreditCardType.create!(card_type:"AMEX", card_description:"American Express")