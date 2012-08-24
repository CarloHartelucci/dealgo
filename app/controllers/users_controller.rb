require 'facebook_oauth'

class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def new
    redirect_to FacebookOauth::oauth_request redirect_uri(params[:type]), session 
  end

  def new_merchant

    @merchant = Merchant.new
    if params[:error].nil?
      profile, access_token, access_token_expiration = FacebookOauth::get_profile redirect_uri("merchant"), session, params
      if !profile.nil?
        @merchant_user = MerchantUser.find_by_fb_user_id(profile["id"])
        if @merchant_user.nil?
          @merchant_user = MerchantUser.new(name:profile["name"], access_token:access_token, 
                                            access_token_expiration:access_token_expiration, 
                                            fb_user_id:profile["id"])
          @merchant_user.save
        end
        if @merchant_user.merchant_id.nil?
          render 'new_merchant'
          return
        else
          sign_in @merchant_user
          redirect_to "/merchants/#{@merchant_user.merchant.merchant_code}"
          return
        end
      end
    end
    redirect_to '/404'
  end

  def new_consumer
    log = Logger.new STDOUT
    log.info "here"
    if params[:error].nil?
      profile, access_token, access_token_expiration = FacebookOauth::get_profile redirect_uri("consumer"), session, params
      if !profile.nil?
        @consumer_user = ConsumerUser.find_by_fb_user_id(profile["id"])
        if @consumer_user.nil?
          log.info "new consumer user"
          @consumer_user = ConsumerUser.new(name:profile["name"], access_token:access_token, 
                                            access_token_expiration:access_token_expiration, 
                                            fb_user_id:profile["id"])
          if !@consumer_user.save
            redirect_to '/404'
            return
          end
        end

        if @consumer_user.email.nil?
          render 'new_consumer'
          return
        else
          sign_in @consumer_user
          redirect_to "/home"
          return
        end
      end
    end
    redirect_to '/404'
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

