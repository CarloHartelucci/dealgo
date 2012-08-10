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

		@errors = []
		@card_types = CreditCardType.all
		@deal = Deal.find(params[:id])
		@purchaser = Purchaser.new(firstname: params[:first_name],
								   lastname: params[:last_name],
								   email: params[:email],
								   phone: params[:phone])
		if @purchaser.valid?
			@purchaser.save
		else
			@purchaser.errors.full_messages.each do |msg|
				@errors << msg
			end
		end

		@payment_info = PaymentInfo.new(purchaser_id: @purchaser.id,
									   card_number: params[:card_number],
									   card_type: params[:card_type],
									   expiration_month: params[:expiration_month],
									   expiration_year: params[:expiration_year])
		if @payment_info.valid?
			@payment_info.save
		else
			@payment_info.errors.full_messages.each do |msg|
				@errors << msg
			end
		end

		@purchase = @deal.create_purchase(@purchaser, Integer(params[:quantity]))
		if @purchase.valid?
			@purchase.save
		end

		if @errors.count == 0
			redirect_to "/confirmation/#{@purchase.id}"
		else
			@purchaser.delete
			@payment_info.delete
			@purchase.delete
			render 'purchase'
		end
	end

	def confirmation
		@purchase = Purchase.find(params[:id])
		@deal = @purchase.deal
	end
end
