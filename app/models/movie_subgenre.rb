class MovieSubgenre < ApplicationRecord
  # Relationships
  belongs_to :movie
  belongs_to :subgenre

  # Validations
  validates :movie_id, presence: true
  validates :subgenre_id, presence: true
  validates :movie_id, uniqueness: { scope: :subgenre_id, message: "has already been assigned this subgenre" }
end
