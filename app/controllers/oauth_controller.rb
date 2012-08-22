class OauthController < ApplicationController
	def oauth
		#oauth = "https://www.facebook.com/dialog/oauth?client_id=380532705350533&redirect_uri=http://localhost:3000/register&scope=user_likes,user_location,user_checkins,user_about_me&state=register"
		oauth = "https://www.facebook.com/dialog/oauth?client_id=#{ENV['FACEBOOK_APP_ID']}&redirect_uri=http://localhost:3000/authorize&scope=user_likes,user_location,user_checkins,user_about_me&state=register"
		
		redirect_to oauth
	end

	def authorize
		if params[:error].nil?
			log = Logger.new STDOUT
			code = params[:code]
			#access_token = "https://graph.facebook.com/oauth/access_token?client_id=380532705350533&redirect_uri=http://localhost:3000/register&client_secret=&code=#{code}"
			access_token = "https://graph.facebook.com/oauth/access_token?client_id=#{ENV['FACEBOOK_APP_ID']}&redirect_uri=http://localhost:3000/authorize&client_secret=#{ENV['FACEBOOK_SECRET']}&code=#{code}"
			
			uri = URI(access_token)
			res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) {|http|
			  
			  	request = Net::HTTP::Get.new uri.request_uri

			  	response = http.request request # Net::HTTPResponse object
			  	log.info response.body

			  	results = {}
			  	response.body.split('&').each do |param|
			  		tokens = param.split('=')
			  		results[tokens[0]] = tokens[1]
			  	end

			  	user_graph = "https://graph.facebook.com/me?access_token=#{results['access_token']}"
			  	uri = URI(user_graph)

			  	request = Net::HTTP::Get.new uri.request_uri

			  	response = http.request request # Net::HTTPResponse object
			  	log.info response.body
			}

			redirect_to "/"

		else
			render '404'
		end
	end
end
