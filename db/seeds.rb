# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Merchant.delete_all
db =
	Merchant.create!(name:"Dirty Bird To Go",
					 website:"http://dirtybirdnyc.com",
					 twitter:"dirtybirdtogo",
					 facebook:"https://www.facebook.com/pages/Dirty-Bird-to-go/122190816732",
					 support_email:"dirtybirdtogo@dirtybirdtogo.com",
					 primary_color: "#F96311",
					 secondary_color: "#C4E243",
					 logo:"/assets/dirtybird.png")
porchetta =
	Merchant.create!(name:"Porchetta",
					 website:"http://porchetta.com",
					 twitter:"porchetta",
					 facebook:"https://www.facebook.com/pages/porchetta/122190816732",
					 support_email:"porchetta@gmail.com")

Deal.delete_all
deal_db =
	Deal.create!(:dealstart => DateTime.now, 
				 :dealend => DateTime.now + 7, 
				 :maxquantity => 100, 
				 :base_price => 25,
				 :name => "September 2012 Referral Program",
				 :description => "Dirty Bird is selling $25 gift cards up to a 15% discount.  The more gift cards we sell the bigger discount you receive.",
				 :merchant_id => db.id)

DealThreshold.delete_all
DealThreshold.create!(discount:5, quantity:0, deal_id: deal_db.id)
DealThreshold.create!(discount:10, quantity:50, deal_id: deal_db.id)
DealThreshold.create!(discount:15, quantity:100, deal_id: deal_db.id)

deal_porchetta =
	Deal.create!(:dealstart => DateTime.now, 
				 :dealend => DateTime.now + 3, 
				 :maxquantity => 50, 
				 :base_price => 100,
				 :name => "September 2012 Referral Program",
				 :description => "Porchetta is selling $100 gift cards up to a 15% discount.  The more gift cards we sell the bigger discount you receive.",
				 :merchant_id => porchetta.id)

DealThreshold.create!(discount:5, quantity:0, deal_id: deal_porchetta.id)
DealThreshold.create!(discount:10, quantity:25, deal_id: deal_porchetta.id)
DealThreshold.create!(discount:15, quantity:50, deal_id: deal_porchetta.id)

Purchaser.delete_all
purchaser1 = Purchaser.create!(firstname:"Test", lastname:"One", 
							 email:"test1@yahoo.com", 
							 phone:"917-867-5309",
							 notification_optin:true)
purchaser2 = Purchaser.create!(firstname:"Test", lastname:"Two", 
							 email:"test2@yahoo.com", 
							 phone:"917-867-5309",
							 notification_optin:true)

Purchase.delete_all
Purchase.create!(quantity:2, purchased_at:DateTime.now, deal_id:deal_db.id, purchaser_id: purchaser1.id)
Purchase.create!(quantity:3, purchased_at:DateTime.now, deal_id:deal_db.id, purchaser_id: purchaser2.id)
Purchase.create!(quantity:5, purchased_at:DateTime.now, deal_id:deal_porchetta.id, purchaser_id: purchaser1.id)
Purchase.create!(quantity:8, purchased_at:DateTime.now, deal_id:deal_porchetta.id, purchaser_id: purchaser2.id)

PaymentInfo.delete_all
pi1 = PaymentInfo.create!(purchaser_id:purchaser1.id, 
						 card_number:12345678987654321, card_type:"VISA",
						 expiration_month:12, expiration_year:2015)
pi2 = PaymentInfo.create!(purchaser_id:purchaser2.id, 
						 card_number:98765432123456789, card_type:"MC",
						 expiration_month:01, expiration_year:2015)


CreditCardType.delete_all
CreditCardType.create!(card_type:"VISA", card_description:"Visa")
CreditCardType.create!(card_type:"MC", card_description:"MasterCard")
CreditCardType.create!(card_type:"AMEX", card_description:"American Express")

User.delete_all
AdminUser.create(:email => "admin1@yahoo.com", 
	        :name => "Admin One", 
	        :password => "letmein", 
	        :password_confirmation => "letmein")
MerchantUser.create!(name:"Diry Bird",
					email:"dirty@yahoo.com",
					password:"letmein",
					password_confirmation:"letmein",
					merchant_id:db.id)


