class Address < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :province

  # Validations
  validates :province, presence: true # Make sure the province is selected
  validates :street, :city, :postal_code, presence: true
  validates :postal_code, format: { with: /\A[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d\z/, message: "must be a valid postal code" }

  # Scopes
  scope :by_province, ->(province_id) { where(province_id: province_id) }

  # Default values for new addresses
  after_initialize :set_default_values, if: :new_record?

  private

  def set_default_values
    self.street ||= ""
    self.city ||= ""
    self.postal_code ||= ""
  end
end
