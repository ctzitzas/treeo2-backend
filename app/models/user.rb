class User < ApplicationRecord
  belongs_to :store
  validates :name, :email, :password_digest, :key, :user_type, presence: true
  validates :email, :key, uniqueness: true
  validates :password_digest, length: { minimum: 8 }
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  enum user_type: { user: 1, admin: 2 }
end
