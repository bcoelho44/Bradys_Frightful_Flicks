class MoviesController < ApplicationController
  def index
    if params[:filter] == "recently_added"
      @movies = Movie.recently_added.includes(:subgenres).order(created_at: :desc)
    else
      @movies = Movie.includes(:subgenres).order(created_at: :desc)
    end
  end

  def show
    @movie = Movie.find(params[:id]) # Fetch a single movie by ID
  end
end
