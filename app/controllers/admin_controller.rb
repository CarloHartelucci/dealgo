class AdminController < ApplicationController
	
	before_filter :signed_in_admin, except: [:new, :create]
	
	def new
  	end

	def create
	  	user = User.find_by_email(params[:email])
	  	if user && user.authenticate(params[:password])
	  	  sign_in user
	  	  flash[:success] = "Welcome to DealGo"
	  	  if user.type == "AdminUser"
	        redirect_to '/admin/merchants'
	      else
	        merchant_user = MerchantUser.find(user.id);
	        redirect_to "/merchants/#{merchant_user.merchant.merchant_code}"
	      end
	  	else
	  	  flash[:error] = 'Invalid email/password combination' # Not quite right!
	      redirect_to '/signin'
	  	end
	end

	def deals
		@active = "deals"
		@deals = Deal.all
		if params[:id].nil?
			redirect_to "/admin/deals/#{@deals.first.id}"
		else
			@active_deal = Deal.find(params[:id])
			@purchases = @active_deal.purchases
		end
	end

	def merchants
		@active = "merchants"
		@merchants = Merchant.all
	end

	protected
	    def signed_in_admin
	      if !signed_in? 
        	store_location
        	redirect_to '/admin', notice: "Please sign in."
	      end
	      if !admin?
	      	redirect_to '/404'
	      end
	    end
end
