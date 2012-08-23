class MerchantsController < ApplicationController

	before_filter :signed_in_merchant_admin, except: [:new, :create]

	def show
		@merchant = Merchant.find_by_merchant_code(params[:id])
	end

	def profile
		@merchant = Merchant.find_by_merchant_code(params[:id])
	end

	def current_deal
		@merchant = Merchant.find_by_merchant_code(params[:id])
	end

	def history
		@merchant = Merchant.find_by_merchant_code(params[:id])
	end

	protected
		def signed_in_merchant_admin
			if !signed_in? 
	        	store_location
	        	redirect_to '/signin', notice: "Please sign in."
		    end 
	      	if current_user.merchant_id != Merchant.find_by_merchant_code(params[:id]).id
	      		redirect_to '/404'
	      	end
		end
end
