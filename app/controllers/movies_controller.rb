class MoviesController < ApplicationController
  def index
    @movies = Movie.includes(:subgenres).order(created_at: :desc) # Fetch all movies with subgenres
  end

  def show
    @movie = Movie.find(params[:id]) # Fetch a single movie by ID
  end
end
