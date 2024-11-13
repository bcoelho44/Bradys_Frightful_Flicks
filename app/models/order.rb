class Order < ApplicationRecord
  # Relationships
  belongs_to :user
  has_many :order_items
  has_many :movies, through: :order_items
end
