class Genre < ApplicationRecord
  # Relationships
  has_and_belongs_to_many :movies, join_table: :movie_genres
end
