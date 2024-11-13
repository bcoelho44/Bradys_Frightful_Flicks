class MovieGenre < ApplicationRecord
  # Relationships
  belongs_to :movie
  belongs_to :genre
end
