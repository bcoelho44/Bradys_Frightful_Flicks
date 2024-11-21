class ProductsController < ApplicationController
  def index
    @q = Movie.includes(:subgenres).ransack(params[:q]) # Initialize Ransack for search and filtering
    @products = @q.result(distinct: true).order(created_at: :desc) # Get filtered results

    if params[:recently_added].present?
      @products = @products.recently_added # Apply the "recently added" filter
    end

    @categories = Subgenre.all # Fetch all categories for the dropdown
  end

  def category
    Rails.logger.debug("Category ID: #{params[:id]}") # Debug log
    @category = Subgenre.find(params[:id]) # Find the subgenre
    @products = @category.movies.order(created_at: :desc) # Fetch movies in that subgenre
    Rails.logger.debug("Movies Count: #{@products.count}") # Debug log
  end

  def show
    @product = Movie.find(params[:id]) # Find a specific movie
  end
end
