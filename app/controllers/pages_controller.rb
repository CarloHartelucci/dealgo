class PagesController < ApplicationController
	def home
		@deal = Deal.first
	end
end
