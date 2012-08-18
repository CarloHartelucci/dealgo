class AdminController < ActionController::Base
	protect_from_forgery
    include SessionsHelper
	
	before_filter :signed_in_admin
	
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
