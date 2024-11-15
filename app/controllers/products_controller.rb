class ProductsController < ApplicationController
  def index
    @products = Movie.includes(:subgenres).order(created_at: :desc) # Fetch all movies
  end

  def category
    @category = Subgenre.find(params[:id]) # Find the subgenre
    @products = @category.movies # Fetch movies in that subgenre
  end

  def show
    @product = Movie.find(params[:id]) # Find a specific movie
  end

  def category
    Rails.logger.debug("Category ID: #{params[:id]}") # Debug log
    @category = Subgenre.find(params[:id]) # Find the subgenre
    @products = @category.movies # Fetch movies in that subgenre
    Rails.logger.debug("Movies Count: #{@products.count}") # Debug log
  end

end
