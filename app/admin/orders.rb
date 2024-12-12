ActiveAdmin.register Order do
  permit_params :status, :user_id, :total_amount, :stripe_session_id, order_items_attributes: [:movie_id, :quantity, :price]

  # Remove the filter for stripe_session_id
  filter :user
  filter :status
  filter :total_amount

  # Display orders in the index page
  index do
    selectable_column
    id_column
    column :user
    column :status
    column :total_amount
    column :stripe_session_id  # Display the stripe session id without filtering
    column "Movies Ordered" do |order|
      # List the movie titles along with their quantities and price
      order.order_items.map { |item| "#{item.movie.title} (x#{item.quantity})" }.join(", ")
    end
    column "Taxes" do |order|
      # Display all taxes (GST, PST, HST)
      gst = (order.calculate_taxes * 0.05).round(2) # 5% GST
      pst = (order.calculate_taxes * 0.07).round(2) # 7% PST
      hst = (order.calculate_taxes * 0.13).round(2) # 13% HST
      "GST: $#{gst}, PST: $#{pst}, HST: $#{hst}"
    end
    column :created_at
    actions
  end

  # Show detailed order information
  show do
    attributes_table do
      row :user
      row :status
      row :total_amount
      row :stripe_session_id  # Display the stripe session id without filtering
      row "Movies Ordered" do |order|
        # List movies ordered with their quantities and price
        order.order_items.map { |item| "#{item.movie.title} (x#{item.quantity}) - $#{item.price} each" }.join(", ")
      end
      row "Taxes" do |order|
        # Calculate and display the tax breakdown for GST, PST, and HST
        gst = (order.calculate_taxes * 0.05).round(2) # 5% GST
        pst = (order.calculate_taxes * 0.07).round(2) # 7% PST
        hst = (order.calculate_taxes * 0.13).round(2) # 13% HST
        "GST: $#{gst}, PST: $#{pst}, HST: $#{hst}"
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
