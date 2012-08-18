class SessionsController < ActionController::Base
  include SessionsHelper
  def new
  end

  def create
  	user = User.find_by_email(params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
  	  sign_in user
  	  flash[:success] = "Welcome to DealGo"
  	  if user.type == "AdminUser"
        redirect_to '/admin/merchants'
      else
        merchant_user = MerchantUser.find(user.id);
        redirect_to "/merchants/#{merchant_user.merchant.merchant_code}"
      end
  	else
  	  flash[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
  	end
  end

  def destroy
  	sign_out
  	redirect_to '/admin'
  end
end
