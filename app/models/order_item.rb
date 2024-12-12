class OrderItem < ApplicationRecord
  # Relationships
  belongs_to :order
  belongs_to :movie

  # Validations
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :order_id, presence: true
  validates :movie_id, presence: true

    # Define ransackable attributes for ActiveAdmin search
    def self.ransackable_attributes(auth_object = nil)
      [
        "id", "movie_id", "order_id", "quantity",
        "price", "created_at", "updated_at"
      ]
    end
end
