class StaticPage < ApplicationRecord
  before_validation :generate_slug, on: :create

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  # Define ransackable attributes for ActiveAdmin search
  def self.ransackable_attributes(auth_object = nil)
    %w[id title content slug created_at updated_at]
  end

  private

  def generate_slug
    if title.present?
      base_slug = title.parameterize
      # Ensure slug is unique by appending a number if needed
      count = 1
      slug_candidate = base_slug
      while StaticPage.exists?(slug: slug_candidate)
        slug_candidate = "#{base_slug}-#{count}"
        count += 1
      end
      self.slug ||= slug_candidate
    end
  end
end
