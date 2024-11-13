class MovieGenre < ApplicationRecord
  # Relationships
  belongs_to :movie
  belongs_to :genre

  # Validations
  validates :movie_id, uniqueness: { scope: :genre_id, message: "has already been assigned this genre" }
end
