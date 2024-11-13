ActiveAdmin.register Order do
  permit_params :user_id, :total_amount, :status

  index do
    selectable_column
    id_column
    column :user
    column :total_amount
    column :status
    column :created_at
    actions
  end
end
