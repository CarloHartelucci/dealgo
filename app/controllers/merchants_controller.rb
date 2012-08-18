class MerchantsController < ApplicationController

	def show
		@merchant = Merchant.find_by_merchant_code(params[:id])
	end
	
	def new
		@merchant = Merchant.new
	end

	def create
		@errors = []
		@user = User.new(name:params[:username],
						 email:params[:email],
						 password:params[:password],
						 password_confirmation:params[:password_confirmation]
						 )
		if !@user.save
			@user.errors.full_messages.each do |msg|
				@errors << msg
			end
			render 'new'
			return
		end

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

		redirect_to "/merchants/#{@merchant.merchant_code}"
	end
end
