class User < ApplicationRecord
  
  password_format = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
/x
  
  belongs_to :store
  validates :name, :email, :password_digest, :key, :user_type, presence: true
  validates :email, :key, uniqueness: true
  validates :password_digest, length: { minimum: 8 }
  validates_format_of :password_digest, with: password_format
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  enum user_type: { user: 1, admin: 2 }
end

