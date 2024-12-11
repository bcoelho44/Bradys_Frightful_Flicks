class AddCascadeDeleteToOrdersAndAddresses < ActiveRecord::Migration[6.0]
  def change
    # Add cascade delete for orders
    add_foreign_key :orders, :users, on_delete: :cascade

    # Add cascade delete for addresses
    add_foreign_key :addresses, :users, on_delete: :cascade
  end
end
