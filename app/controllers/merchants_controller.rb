class MerchantsController < ApplicationController

	before_filter :signed_in_merchant_admin, only: :show

	def show
		@merchant = Merchant.find_by_merchant_code(params[:id])
	end
	
	def new
		@merchant = Merchant.new
	end

	def create
		@errors = []
		@merchant = Merchant.new(facebook:params[:facebook], 
								 name:params[:name], 
								 twitter:params[:twitter], 
								 website:params[:website], 
								 support_email:params[:support_email])
		if !@merchant.save
			@merchant.errors.full_messages.each do |msg|
				@errors << msg
			end
			render 'new'
			return
		end

		@merchant_user = MerchantUser.new(name:params[:username],
						 email:params[:email],
						 password:params[:password],
						 password_confirmation:params[:password_confirmation],
						 merchant_id:@merchant.id
						 )

		if !@merchant_user.save
			@merchant_user.errors.full_messages.each do |msg|
				@errors << msg
			end
			render 'new'
			return
		end
		sign_in @merchant_user
		redirect_to "/merchants/#{@merchant.merchant_code}"
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
