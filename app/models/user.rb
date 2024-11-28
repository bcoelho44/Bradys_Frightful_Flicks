class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Relationships
  has_many :orders, dependent: :destroy
  has_one :addresses, dependent: :destroy
  belongs_to :province, optional: false

  # Nested attributes for address
  accepts_nested_attributes_for :addresses, allow_destroy: true

  # Validations
  validates :province_id, presence: { message: "Please select a province" }

  # Define the ransackable attributes
  def self.ransackable_attributes(auth_object = nil)
    ["email", "created_at", "updated_at", "province_id"]
  end

  # Define the ransackable associations
  def self.ransackable_associations(auth_object = nil)
    ["address", "province"]  # Allow address and province to be searchable
  end
end
