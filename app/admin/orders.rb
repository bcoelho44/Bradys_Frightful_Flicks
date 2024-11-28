ActiveAdmin.register Order do
  permit_params :user_id, :status, :total_amount, order_items_attributes: [:id, :movie_id, :quantity, :price, :_destroy]

  # Filters
  filter :status, as: :select, collection: %w[pending paid shipped]
  filter :user
  filter :created_at

  # Index Page
  index do
    selectable_column
    column :id
    column :user
    column :status
    column :total_amount
    column 'Movies' do |order|
      order.movies.map(&:title).join(', ')
    end
    column :created_at
    actions
  end

  # Form for creating/editing an order
  form do |f|
    f.inputs 'Order Details' do
      f.input :user, as: :select, collection: User.all.map { |u| [u.email, u.id] }
      f.input :status, as: :select, collection: %w[pending paid shipped]
      f.input :total_amount
      f.has_many :order_items, allow_destroy: true do |oi|
        oi.input :movie
        oi.input :quantity
        oi.input :price
      end
    end
    f.actions
  end
end
