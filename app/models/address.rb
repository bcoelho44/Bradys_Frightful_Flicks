class Address < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :province

  # Validations
  validates :street, :city, :postal_code, :province_id, presence: true
  validates :postal_code, format: { with: /\A[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d\z/, message: "must be a valid postal code" }

  # Scopes
  scope :by_province, ->(province_id) { where(province_id: province_id) }
end
