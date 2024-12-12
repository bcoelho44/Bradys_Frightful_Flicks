class AdminUser < ApplicationRecord
  # Include default devise modules
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  # Validations
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :password, length: { minimum: 6 }, if: :password_required?

  # Define ransackable attributes for ActiveAdmin search
  def self.ransackable_attributes(auth_object = nil)
    ["id", "email", "created_at", "updated_at"]
  end

  # Check if user is admin
  def admin?
    true
  end
end
