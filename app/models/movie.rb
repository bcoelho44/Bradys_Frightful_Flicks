class Movie < ApplicationRecord
  # Relationships
  has_and_belongs_to_many :genres, join_table: :movie_genres
  has_many :order_items
  has_many :orders, through: :order_items

  # Validations
  validates :title, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :release_year, numericality: { only_integer: true }, allow_nil: true
  validates :director, presence: true
  validates :runtime, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
end
