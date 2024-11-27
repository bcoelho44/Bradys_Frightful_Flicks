class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
    @cart_items = session[:cart] || {} # Retrieve cart items from session
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.status = 'pending'

    # Process cart items
    ActiveRecord::Base.transaction do
      subtotal = 0

      (session[:cart] || {}).each do |movie_id, quantity|
        movie = Movie.find(movie_id)
        subtotal += movie.price * quantity
        @order.order_items.build(movie: movie, quantity: quantity, price: movie.price)
      end

      @order.total_amount = subtotal + @order.calculate_taxes

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

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :status)
  end
end
