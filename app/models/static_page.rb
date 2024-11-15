class StaticPage < ApplicationRecord
  before_validation :generate_slug, on: :create

  validates :slug, presence: true, uniqueness: true
  # Add this method
  def self.ransackable_attributes(auth_object = nil)
    %w[id title content slug created_at updated_at]
  end

  private

  def generate_slug
    self.slug ||= title.parameterize if title.present?
  end
end
