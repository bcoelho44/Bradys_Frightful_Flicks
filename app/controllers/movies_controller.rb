class MoviesController < ApplicationController
  def index
    @movies = Movie.includes(:subgenres).order(created_at: :desc)
  end
end
