class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Relationships
  has_many :orders, dependent: :destroy
  has_one :address, dependent: :destroy
  belongs_to :province, optional: false

  # Nested attributes for address
  accepts_nested_attributes_for :address, allow_destroy: true

  # Validations
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :province_id, presence: { message: "Please select a province" }
  validates :password, length: { minimum: 6 }, allow_nil: true # Ensuring password length

    # Configure permitted parameters
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [
        :province_id,
        address_attributes: [:street, :city, :postal_code, :province_id]
      ])
      devise_parameter_sanitizer.permit(:account_update, keys: [
        :province_id,
        address_attributes: [:street, :city, :postal_code, :province_id]
      ])
    end

  # Define the ransackable attributes
  def self.ransackable_attributes(auth_object = nil)
    ["email", "created_at", "updated_at", "province_id"]
  end

  # Define the ransackable associations
  def self.ransackable_associations(auth_object = nil)
    ["address", "province"]
  end
end
