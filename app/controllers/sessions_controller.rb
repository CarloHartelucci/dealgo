class SessionsController < ActionController::Base
  include SessionsHelper
  def new
  end

  def create
  	user = User.find_by_email(params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
  	  sign_in user
  	  flash[:success] = "Welcome to DealGo"
  	  redirect_to '/admin/purchases'
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
