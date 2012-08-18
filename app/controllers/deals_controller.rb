class DealsController < ActionController::Base
	protect_from_forgery
    include SessionsHelper

	def home
		merchant_code = Merchant.first.merchant_code
		redirect_to "/deals/#{merchant_code}"
	end

	def deal
		@deal = Merchant.find_by_merchant_code(params[:merchant_code]).deals.first
	end

	def purchase
		@deal = Merchant.find_by_merchant_code(params[:merchant_code]).deals.first
		@card_types = CreditCardType.all
		@url = params[:url]
	end

	def submit
		logger = Logger.new STDOUT

		@card_types = CreditCardType.all
		@deal = Merchant.find_by_merchant_code(params[:merchant_code]).deals.first
		
		@errors, purchase_code = @deal.create_purchase params

		if @errors.count == 0
			redirect_to "/deals/#{params[:merchant_code]}/#{purchase_code}"
		else
			render 'purchase'
		end
	end

	def confirmation
		@purchase = Purchase.find_by_purchase_code(params[:purchase_code])
		@deal = Merchant.find_by_merchant_code(params[:merchant_code]).deals.first
	end
end
