class Movie < ApplicationRecord
  # Relationships
  has_and_belongs_to_many :genres, join_table: :movie_genres
  has_many :order_items
  has_many :orders, through: :order_items
end
