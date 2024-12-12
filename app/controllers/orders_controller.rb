class OrdersController < ApplicationController

  before_action :authenticate_user!

  # Displays all past orders for a customer
  def index
    @orders = current_user.orders.includes(order_items: :movie) # Fetch orders and associated items for current user
  end

  # Displays all orders for all customers (for admins)
  def admin_index
    # Only allow admins to view this
    authorize_admin! # Ensure user is an admin (you can define this method as per your authentication setup)
    @orders = Order.includes(order_items: :movie).all # Fetch all orders for admin
  end

  # Displays the order checkout page
  def new
    @order = Order.new
    @cart_items = session[:cart] || {} # Fetch items from the cart
  end

  # Handles the order creation and Stripe payment processing
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
        # Create a Stripe Checkout session with updated line_items format and mode
        session = Stripe::Checkout::Session.create({
          payment_method_types: ['card'],
          line_items: @order.order_items.map do |item|
            {
              price_data: {
                currency: 'usd',  # You can replace 'usd' with the appropriate currency
                product_data: {
                  name: item.movie.title,
                },
                unit_amount: (item.price * 100).to_i,  # Stripe accepts amount in cents
              },
              quantity: item.quantity,
            }
          end,
          mode: 'payment',  # This is the required mode for one-time payments
          success_url: order_url(@order) + "?session_id={CHECKOUT_SESSION_ID}",
          cancel_url: root_url,
        })

        # Redirect to Stripe Checkout page
        redirect_to session.url, allow_other_host: true
      else
        render :new, alert: "Failed to place order. Please try again."
      end
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to cart_index_path, alert: "One or more items in your cart are no longer available."
  end



  # Displays an individual order's details
  def show
    @order = Order.find_by(id: params[:id], user: current_user)
    unless @order
      redirect_to root_path, alert: "Order not found or you do not have access to this order."
    end
  end

  private

  # Permitted parameters for creating/updating an order
  def order_params
    params.require(:order).permit(:user_id, :status, :total_amount, order_items_attributes: [:movie_id, :quantity, :price])
  end

  # Custom method to ensure user is an admin
  def authorize_admin!
    redirect_to root_path unless current_user.admin? # You can adjust this check as per your needs
  end
end
