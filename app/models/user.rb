class User < ActiveRecord::Base
  attr_accessible :email, :name, :access_token, :access_token_expiration, :fb_user_id


  validates :name, presence: true, length: {maximum: 50}

  before_save :create_remember_token

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end