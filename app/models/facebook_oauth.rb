require 'net/http'
require 'digest/md5'

class FacebookOauth
	FB_ACCESS_SCOPE = "user_likes,user_location,user_checkins,user_about_me"
	def self.oauth_request(redirect_uri, session)
		state = Digest::MD5.hexdigest(SecureRandom.urlsafe_base64)
		session[:state] = state
		fb_oauth_path = "https://www.facebook.com/dialog/oauth?client_id=#{ENV['FACEBOOK_APP_ID']}&redirect_uri=#{redirect_uri}&scope=#{FB_ACCESS_SCOPE}&state=#{state}"
		return fb_oauth_path
	end

	def self.get_profile(redirect_uri, session, params)
		code = params[:code]
    	state = params[:state]

     	if session[:state] == state
      		fb_access_token_path = "https://graph.facebook.com/oauth/access_token?client_id=#{ENV['FACEBOOK_APP_ID']}&redirect_uri=#{redirect_uri}&client_secret=#{ENV['FACEBOOK_SECRET']}&code=#{code}"
	    	uri = URI(fb_access_token_path)
	    	res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) {|http|       
		    	request = Net::HTTP::Get.new uri.request_uri

		        response = http.request request # Net::HTTPResponse object
		        if response.is_a? Net::HTTPSuccess 
		       		results = {}
	          		response.body.split('&').each do |param|
	            		tokens = param.split('=')
	            		results[tokens[0]] = tokens[1]
	          		end

	          		access_token = results["access_token"]
	          		access_token_expiration = results["access_token_expiration"]

	          		fb_user_graph = "https://graph.facebook.com/me?access_token=#{access_token}"
	          		uri = URI(fb_user_graph)

	          		request = Net::HTTP::Get.new uri.request_uri

	          		response = http.request request # Net::HTTPResponse object

	          		if response.is_a? Net::HTTPSuccess
	            		profile = JSON.parse(response.body)
	            		return profile, access_token, access_token_expiration
	            	end
	            end
	        }
        end
        return {}
	end	
end