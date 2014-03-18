class Provider < ActiveRecord::Base
  before_save { self.email = email.downcase }
	validates :username,  presence: true, length: { maximum: 70 }
	validates :office,  presence: true
	validates :role,  presence: true
	validates :access,  presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
     uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, length: { minimum: 8 }
end
