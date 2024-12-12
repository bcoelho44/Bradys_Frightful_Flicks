class Subgenre < ApplicationRecord
  # Relationships
  has_and_belongs_to_many :movies, join_table: :movie_subgenres

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates_length_of :name, maximum: 50
  validates :name, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }

  # Callbacks
  before_save :capitalize_name

  # Scopes
  scope :alphabetical, -> { order(:name) }
  scope :recent, -> { order(created_at: :desc) }

  # Ransack customization
  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[movies]
  end

  private

  def capitalize_name
    self.name = name.capitalize
  end
end
