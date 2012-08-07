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
Deal.create!(:dealstart => DateTime.now, 
			 :dealend => DateTime.now + 7, 
			 :maxquantity => 100, 
			 :name => "Dirty Bird Referral Program",
			 :merchant_id => db.id)