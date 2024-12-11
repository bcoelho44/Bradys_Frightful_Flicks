ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :role, :province_id, address_attributes: [:street, :city, :postal_code]

  # Filters for searching users
  filter :email
  filter :created_at

  # Index page - displayed when admins view the list of users
  index do
    selectable_column
    id_column
    column :email
    column :role
    column :province
    column :created_at
    actions
  end

  # Show page - view details of a single user
  show do
    attributes_table do
      row :email
      row :role
      row :province
      row :created_at
      row :updated_at
      row :address do |user|
        user.address.present? ? "#{user.address.street}, #{user.address.city}, #{user.address.postal_code}" : "No address provided"
      end
    end

    # Display user's past orders
    panel "Past Orders" do
      table_for user.orders do
        column :id
        column :status
        column :total_amount
        column "Movies Ordered" do |order|
          order.movies.map { |movie| movie.title }.join(", ")
        end
        column :created_at
        column :updated_at
      end
    end
  end

  # Form for creating/editing users
  form do |f|
    f.inputs 'User Details' do
      f.input :email
      f.input :role, as: :select, collection: ['customer', 'admin']
      f.input :province
      f.input :password
      f.input :password_confirmation
    end
    f.inputs 'Address' do
      f.has_many :address, allow_destroy: true, new_record: true do |a|
        a.input :street
        a.input :city
        a.input :postal_code
      end
    end
    f.actions
  end
end
