class CartController < ApplicationController
  before_action :initialize_cart

  def index
    # Fetch items from session
    @cart_items = @cart.map do |movie_id, quantity|
      movie = Movie.find(movie_id)
      { movie: movie, quantity: quantity }
    end
  end

  def update
    # Update item quantity in the session
    movie_id = params[:movie_id]
    new_quantity = params[:quantity].to_i

    if new_quantity > 0
      @cart[movie_id] = new_quantity
      flash[:notice] = "Quantity updated!"
    else
      @cart.delete(movie_id)
      flash[:alert] = "Item removed from the cart!"
    end

    session[:cart] = @cart
    redirect_to cart_index_path
  end

  def remove
    # Remove item from cart
    movie_id = params[:movie_id]
    @cart.delete(movie_id)
    session[:cart] = @cart
    flash[:alert] = "Item removed!"
    redirect_to cart_index_path
  end

  private

  def initialize_cart
    session[:cart] ||= {}
    @cart = session[:cart]
  end
end
