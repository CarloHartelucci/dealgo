require 'net/http'

class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def new
    #fb_oauth_path = "https://www.facebook.com/dialog/oauth?client_id=380532705350533&redirect_uri=http://localhost:3000/register&scope=user_likes,user_location,user_checkins,user_about_me&state=register"
    fb_oauth_path = "https://www.facebook.com/dialog/oauth?client_id=#{ENV['FACEBOOK_APP_ID']}&redirect_uri=http://localhost:3000/authorize&scope=user_likes,user_location,user_checkins,user_about_me&state=#{params[:type]}"
    redirect_to fb_oauth_path
  end

  def authorize
    if params[:error].nil?
      log = Logger.new STDOUT
      code = params[:code]
      state = params[:state]
      #access_token = "https://graph.facebook.com/oauth/access_token?client_id=380532705350533&redirect_uri=http://localhost:3000/register&client_secret=&code=#{code}"
      fb_access_token = "https://graph.facebook.com/oauth/access_token?client_id=#{ENV['FACEBOOK_APP_ID']}&redirect_uri=http://localhost:3000/authorize&client_secret=#{ENV['FACEBOOK_SECRET']}&code=#{code}"
      
      uri = URI(fb_access_token)
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
            logger.info profile
            logger.info profile["id"]
            @user = User.find_by_fb_user_id(profile["id"])
            logger.info @user
            if @user.nil?

              if state == "merchant"
                @user = MerchantUser.new(name:profile["name"], access_token:access_token, 
                                         access_token_expiration:access_token_expiration, 
                                         fb_user_id:profile["id"])
                if @user.save
                  render 'new_merchant'
                  return
                end
              else
                @user = ConsumerUser.new(name:profile["name"], access_token:access_token, 
                                         access_token_expiration:access_token_expiration, 
                                         fb_user_id:profile["id"])
                if @user.save
                  render 'new_consumer'
                  return
                end
              end              
            else
              if @user.type == "MerchantUser"
                @user = MerchantUser.find(@user.id)
                sign_in @user
                redirect_to "/merchants/#{@user.merchant.merchant_code}"
                return
              else
                @user = ConsumerUser.find(@user.id)
                sign_in @user
                redirect_to "/home"
                return
              end
            end
          end
        end
      }
    end
    redirect_to '/500'
  end

  def new_merchant
    @merchant = Merchant.new
  end

  def create_merchant
    @errors = []
    @user = MerchantUser.find(params[:user_id])
    @merchant = Merchant.new(facebook:params[:facebook], 
                 name:params[:name], 
                 twitter:params[:twitter], 
                 website:params[:website], 
                 support_email:params[:support_email])
    if !@merchant.save
      @merchant.errors.full_messages.each do |msg|
        @errors << msg
      end
      render 'new_merchant'
      return
    end
    @user.merchant_id = @merchant.id
    @user.save
    sign_in @user
    redirect_to "/merchants/#{@merchant.merchant_code}"
  end

  def new_consumer

  end

  def create_consumer
    @errors = []
    @user = ConsumerUser.find(params[:user_id])
    @user.email = params[:email]
    @user.twitter = params[:twitter]
    @user.user_name = params[:user_name]
    @user.save
    sign_in @user

    redirect_to "/home"
  end
end

