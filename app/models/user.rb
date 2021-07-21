class User < ApplicationRecord

  before_create :randomise_key
  
  has_secure_password
  belongs_to :store
  validates :name, :email, :password_digest, :user_type, :store_id, presence: true
  validates :email, :key, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  enum user_type: { user: 1, admin: 2 }
  attribute :user_type, :integer, default: 1

  private

  def randomise_key
    begin
      self.key = SecureRandom.alphanumeric(10)
    end while self.class.where(key: self.key).exists?
  end
end

