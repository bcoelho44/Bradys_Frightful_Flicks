class AddProvinceIdToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :province_id, :integer
  end
end
