class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include MerchantsHelper
  include UsersHelper
end
