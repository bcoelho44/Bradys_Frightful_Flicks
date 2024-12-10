class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Relationships
  has_many :orders, dependent: :destroy
  has_one :address, dependent: :destroy  # Revert back to has_one for single address
  belongs_to :province, optional: false

  # Nested attributes for address
  accepts_nested_attributes_for :address, allow_destroy: true  # Use accepts_nested_attributes_for for one address

  # Validations
  validates :province_id, presence: { message: "Please select a province" }

  # Define the ransackable attributes
  def self.ransackable_attributes(auth_object = nil)
    ["email", "created_at", "updated_at", "province_id"]
  end

  # Define the ransackable associations
  def self.ransackable_associations(auth_object = nil)
    ["address", "province"]  # Keep address as singular here
  end
end
