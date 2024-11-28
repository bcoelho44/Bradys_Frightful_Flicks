class Province < ApplicationRecord
  # Relationships
  has_many :addresses, dependent: :restrict_with_error
  has_many :users, through: :addresses

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :gst, :pst, :hst, numericality: { greater_than_or_equal_to: 0 }

  # Methods
  def total_tax_rate
    gst + pst + hst
  end
end
