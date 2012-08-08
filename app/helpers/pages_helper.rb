module PagesHelper
	def card_types
		cc_types = []
		cc_types << {"cc_type" => "VISA", "cc_name" => "Visa"}
		cc_types << {"cc_type" => "MC", "cc_name" => "MasterCard"}
		cc_types << {"cc_type" => "AMEX", "cc_name" => "American Express"}
		return cc_types
	end
end
