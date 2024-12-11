class AddDefaultAddressToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :addresses, :street, ""  # Ensure a default value for street
    change_column_default :addresses, :city, ""
    change_column_default :addresses, :postal_code, ""
  end
end
