class OrdersController < ApplicationController
  before_action :authenticate_user!

  # Displays the order checkout page
  def new
    @order = Order.new
    @cart_items = session[:cart] || {} # Fetch items from the cart
  end

  # Handles the order creation
  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.status = 'pending'

    # Process cart items within a transaction
    ActiveRecord::Base.transaction do
      subtotal = 0

      (session[:cart] || {}).each do |movie_id, quantity|
        movie = Movie.find(movie_id)
        subtotal += movie.price * quantity
        @order.order_items.build(movie: movie, quantity: quantity, price: movie.price)
      end

      # Calculate the total amount including taxes
      @order.total_amount = subtotal + @order.calculate_taxes

      # Save the order to the database
      if @order.save
        session[:cart] = nil # Clear cart after successful order
        redirect_to @order, notice: "Order successfully placed."
      else
        render :new, alert: "Failed to place order. Please try again."
      end
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to cart_index_path, alert: "One or more items in your cart are no longer available."
  end

  # Displays an individual order's details
  def show
    # Ensure the order belongs to the current user
    @order = Order.find_by(id: params[:id], user: current_user)

    # Redirect if the order is not found or doesn't belong to the current user
    unless @order
      redirect_to root_path, alert: "Order not found or you do not have access to this order."
    end
  end

  private

  # Permitted parameters for creating/updating an order
  def order_params
    params.require(:order).permit(:user_id, :status, :total_amount, order_items_attributes: [:movie_id, :quantity, :price])
  end
end
