class User < ApplicationRecord
	has_many :user_permissions
	has_secure_password
	before_save { self.email = email.downcase }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 1 }
end
