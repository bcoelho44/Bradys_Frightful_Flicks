class ProductsController < ApplicationController
  def index
    # Initialize Ransack for keyword search and filtering
    @q = Movie.ransack(params[:q])
    # Get filtered results and order them by creation date
    @products = @q.result(distinct: true).order(created_at: :desc)

    # Apply the "recently added" filter if specified
    @products = @products.recently_added if params[:recently_added].present?

    # Fetch all categories (subgenres) for the dropdown menu
    @categories = Subgenre.all
  end

  def category
    Rails.logger.debug("Category ID: #{params[:id]}") # Debug log
    # Find the subgenre by ID
    @category = Subgenre.find(params[:id])
    # Fetch movies associated with the selected subgenre, ordered by creation date
    @products = @category.movies.order(created_at: :desc)
    Rails.logger.debug("Movies Count: #{@products.count}") # Debug log
  end

  def show
    # Find a specific movie by its ID
    @product = Movie.find(params[:id])
  end

  def add_to_cart
    # Add a product to the cart
    movie_id = params[:id]
    quantity = params[:quantity].to_i

    # Initialize cart if not already done
    session[:cart] ||= {}
    cart = session[:cart]

    if cart[movie_id]
      # If the product already exists in the cart, update the quantity
      cart[movie_id] += quantity
    else
      # Otherwise, add the product to the cart
      cart[movie_id] = quantity
    end

    session[:cart] = cart
    flash[:notice] = "Product added to cart!"
    redirect_to cart_index_path
  end
end
