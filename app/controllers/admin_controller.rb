class AdminController < ActionController::Base
	protect_from_forgery
    include SessionsHelper
	
	before_filter :signed_in_user, only: :purchases
	
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
	    def signed_in_user
	      unless signed_in?
	        store_location
	        redirect_to '/admin', notice: "Please sign in." unless signed_in?
	      end
	    end
end
