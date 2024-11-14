ActiveAdmin.register Order do
  permit_params :user_id, :status, :total_amount

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
    column :created_at
    actions
  end

  # Form for creating/editing an order
  form do |f|
    f.inputs 'Order Details' do
      f.input :user, as: :select, collection: User.all.map { |u| [u.email, u.id] }
      f.input :status, as: :select, collection: %w[pending paid shipped]
      f.input :total_amount
    end
    f.actions
  end
end
