class CartController < ApplicationController
  before_action :initialize_cart

  def index
    @cart_items = Movie.where(id: @cart.keys).map do |movie|
      { movie: movie, quantity: @cart[movie.id.to_s] }
    end

    # Clean invalid items
    clean_invalid_items
  end

  def update
    movie_id = params[:movie_id].to_s
    new_quantity = params[:quantity].to_i

    if new_quantity > 0 && @cart.key?(movie_id)
      @cart[movie_id] = new_quantity
      flash[:notice] = "Updated the quantity for #{Movie.find_by(id: movie_id)&.title || 'item'}!"
    elsif new_quantity <= 0
      remove_from_cart(movie_id)
    else
      flash[:alert] = "Invalid movie!"
    end

    update_session_cart
    redirect_to cart_index_path
  end

  def remove
    movie_id = params[:movie_id].to_s
    remove_from_cart(movie_id)
    redirect_to cart_index_path
  end

  private

  def initialize_cart
    session[:cart] ||= {}
    @cart = session[:cart]
  end

  def update_session_cart
    session[:cart] = @cart
  end

  def remove_from_cart(movie_id)
    movie = Movie.find_by(id: movie_id)
    @cart.delete(movie_id)
    flash[:alert] = "#{movie&.title || 'Item'} removed from your cart!"
    update_session_cart
  end

  def clean_invalid_items
    @cart.keys.each do |movie_id|
      unless Movie.exists?(id: movie_id)
        @cart.delete(movie_id)
      end
    end
    update_session_cart
  end
end
