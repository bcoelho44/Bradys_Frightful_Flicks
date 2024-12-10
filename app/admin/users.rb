ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :role, :province_id, address_attributes: [:street, :city, :postal_code, :province_id]

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
    column "Address" do |user|
      if user.address
        "#{user.address.street}, #{user.address.city}, #{user.address.postal_code}, #{user.address.province.name}"
      else
        "No address provided"
      end
    end
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
      row "Address" do |user|
        if user.address
          "#{user.address.street}, #{user.address.city}, #{user.address.postal_code}, #{user.address.province.name}"
        else
          "No address provided"
        end
      end
    end
    active_admin_comments
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
      f.has_one :address, allow_destroy: true do |a|
        a.input :street
        a.input :city
        a.input :postal_code
        a.input :province
      end
    end
    f.actions
  end
end
