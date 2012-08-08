class PagesController < ApplicationController
	def home
		@deal = Deal.first
	end

	def purchase
		@deal = Deal.find(params[:id])
		@card_types = CreditCardType.all
	end

	def submit
		logger = Logger.new STDOUT

		logger.info params

		@purchaser = Purchaser.new
		@purchaser.firstname = params[:purchase][:first_name]
		@purchaser.lastname = params[:purchase][:last_name]
		@purchaser.email = params[:purchase][:email]
		@purchaser.phone = params[:purchase][:phone]
		@purchaser.save

		logger.info @purchaser

		@purchase = Purchase.new
		@purchase.purchased_at = DateTime.now
		@purchase.deal_id = params[:id]
		@purchase.quantity = params[:purchase][:quantity]
		@purchase.purchaser_id = @purchaser.id
		@purchase.save

		logger.info @purchase

		@payment_info = PaymentInfo.new
		@payment_info.card_number = params[:purchase][:card_number]
		@payment_info.card_type = "AMEX"
		@payment_info.expiration_month = params[:purchase][:expiration_month]
		@payment_info.expiration_year = params[:purchase][:expiration_year]
		@payment_info.purchaser_id = @purchaser.id
		@payment_info.save

		logger.info @payment_info

		redirect_to "/confirmation/#{@purchase.id}"
	end

	def confirmation
		@purchase = Purchase.find(params[:id])
		@deal = @purchase.deal
	end
end
