class Order < ApplicationRecord
  # Relationships
  belongs_to :user
  has_many :order_items
  has_many :movies, through: :order_items

  # Validations
  validates :total_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true, inclusion: { in: %w[pending paid shipped], message: "%{value} is not a valid status" }

  # Define ransackable attributes for ActiveAdmin search
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "status", "total_amount", "updated_at", "user_id"]
  end

  # Define ransackable associations for completeness
  def self.ransackable_associations(auth_object = nil)
    ["user", "order_items", "movies"]
  end

  # Tax Calculation Logic
  def calculate_taxes
    province = user.address.province
    subtotal = order_items.sum { |item| item.price * item.quantity }

    gst = (province.gst / 100) * subtotal
    pst = (province.pst / 100) * subtotal
    hst = (province.hst / 100) * subtotal

    gst + pst + hst
  end

  # Total Amount Calculation
  def calculate_total
    subtotal = order_items.sum { |item| item.price * item.quantity }
    taxes = calculate_taxes
    self.total_amount = subtotal + taxes
  end
end
