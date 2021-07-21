class Store < ApplicationRecord
  has_many :users
  validates :name, :key, presence: true, uniqueness: true
  validates :address, :suburb, :postcode, presence: true
  validates :state, presence: true, length: { minimum: 2 }
end
