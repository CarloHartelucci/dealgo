class ConsumerUser < User
  attr_accessible :email, :user_name, :twitter

  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  # 			     uniqueness: { case_sensitive: false }
  #validates :user_name, presence: true, uniqueness: { case_sensitiive: false }

  before_save { |user| if !user.email.nil? 
  					     user.email = email.downcase
  					   end }
end
