class Movie < ApplicationRecord
  # Active Storage attachment
  has_one_attached :image

  # Relationships
  has_and_belongs_to_many :subgenres, join_table: :movie_subgenres
  has_many :order_items
  has_many :orders, through: :order_items

  # Validations
  validates :title, presence: true, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :stock_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :image, presence: true

  # Scopes
  scope :recently_added, -> { where("created_at >= ?", 3.days.ago) }

  # Ransack customization
  def self.ransackable_attributes(auth_object = nil)
    %w[title description price stock_quantity release_year director runtime created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[subgenres order_items orders]
  end

  # Custom Ransack Scope
  def self.ransackable_scopes(auth_object = nil)
    super + %i[subgenre_id_eq]
  end


  # Scope to filter by subgenre ID
  scope :subgenre_id_eq, ->(subgenre_id) {
    joins(:subgenres).where(subgenres: { id: subgenre_id }).distinct
  }
end
