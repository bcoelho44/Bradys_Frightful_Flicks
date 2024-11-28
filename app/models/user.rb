class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Relationships
  has_one :address, dependent: :destroy
  belongs_to :province, optional: true

  # Nested attributes for address
  accepts_nested_attributes_for :address, allow_destroy: true

  # Validations
  validates :province_id, presence: true, unless: :skip_province_validation?
  validates :role, inclusion: { in: ["customer"] } # Restrict role to "customer"

  # Callbacks
  before_validation :set_default_role, on: :create

  private

  def set_default_role
    self.role ||= "customer"
  end

  def skip_province_validation?
    role == "admin"
  end
end
