module UsersHelper
	def redirect_uri(type)
	    redirect_uri = "http://" << request.host_with_port << "/register/" << type
	end
end
