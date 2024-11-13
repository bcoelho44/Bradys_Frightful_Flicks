class Order < ApplicationRecord
  # Relationships
  belongs_to :user
  has_many :order_items
  has_many :movies, through: :order_items

  # Validations
  validates :total_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true, inclusion: { in: %w[pending paid shipped], message: "%{value} is not a valid status" }
end
