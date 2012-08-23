class ConsumersController < ApplicationController

	before_filter :signed_in_consumer


	def home
		@consumer_user = ConsumerUser.find(current_user.id)
	end

	protected
		def signed_in_consumer
			if !signed_in? 
	        	store_location
	        	redirect_to '/signin', notice: "Please sign in."
		    end
		    if current_user.type != "ConsumerUser" 
	      		redirect_to '/404'
	      	end
		end
end
