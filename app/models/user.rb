class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Relationships
  has_many :orders, dependent: :destroy
  has_one :address, dependent: :destroy
  belongs_to :province, optional: true

  # Nested attributes for address
  accepts_nested_attributes_for :address, allow_destroy: true

  # Validations
  validates :province_id, presence: true, unless: :skip_province_validation?
  validates :role, inclusion: { in: ["customer"] } # Restrict role to "customer"

  # Callbacks
  before_validation :set_default_role, on: :create

  # Define the ransackable attributes
  def self.ransackable_attributes(auth_object = nil)
    ["email", "role", "created_at", "updated_at", "province_id"]
  end

  # Define the ransackable associations
  def self.ransackable_associations(auth_object = nil)
    ["address", "province"]  # Allow address and province to be searchable
  end

  private

  def set_default_role
    self.role ||= "customer"
  end

  def skip_province_validation?
    role == "admin"
  end
end
