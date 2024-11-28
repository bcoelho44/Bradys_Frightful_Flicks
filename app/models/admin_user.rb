class AdminUser < ApplicationRecord
  # Include default devise modules
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  # Define ransackable attributes for ActiveAdmin search
  def self.ransackable_attributes(auth_object = nil)
    ["id", "email", "created_at", "updated_at"] # You can add more searchable attributes here
  end

  # Check if user is admin
  def admin?
    true  # All AdminUser entries are assumed to be admins, no need for a role column
  end
end
