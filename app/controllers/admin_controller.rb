class AdminController < ActionController::Base
	protect_from_forgery
    include SessionsHelper
	
	before_filter :signed_in_user, only: :purchases
	
	def purchases
		@active = "purchases"
		@purchases = Deal.first.purchases
	end

	def merchants
		@active = "merchants"
		@merchants = Merchant.all
	end

	protected
	    def signed_in_user
	      unless signed_in?
	        store_location
	        redirect_to '/admin', notice: "Please sign in." unless signed_in?
	      end
	    end
end
