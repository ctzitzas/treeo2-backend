class Purchase < ApplicationRecord
  belongs_to :user
  validates :user_id, :receipt_url, :payment_intent_id, presence: true
end
