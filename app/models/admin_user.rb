class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  # Define ransackable attributes for ActiveAdmin search
  def self.ransackable_attributes(auth_object = nil)
    ["id", "email", "created_at", "updated_at"] # Add attributes you want searchable
  end
end
