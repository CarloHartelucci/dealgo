class PagesController < ApplicationController
	def deal
		@deal = Deal.first
	end

	def purchase
		@deal = Deal.find(params[:id])
		@card_types = CreditCardType.all
		@url = params[:url]
	end

	def submit
		logger = Logger.new STDOUT

		@card_types = CreditCardType.all
		@deal = Deal.find(params[:id])
		
		@errors, purchase_code = @deal.create_purchase params

		if @errors.count == 0
			redirect_to "/confirmation/#{purchase_code}"
		else
			render 'purchase'
		end
	end

	def confirmation
		@purchase = Purchase.find_by_purchase_code(params[:id])
		@deal = @purchase.deal
	end
end
