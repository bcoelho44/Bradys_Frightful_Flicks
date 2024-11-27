class Address < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :province

  # Validations
  validates :street, :city, :province, :postal_code, presence: true
  validates :postal_code, format: { with: /\A[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d\z/, message: "must be a valid postal code" }
end
