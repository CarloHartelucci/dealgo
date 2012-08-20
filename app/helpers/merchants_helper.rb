module MerchantsHelper
	def authorized_merchant_admin?
		return signed_in? && current_user.merchant_id == Merchant.find_by_merchant_code(params[:id]).id
	end
end
