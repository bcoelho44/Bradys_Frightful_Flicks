ActiveAdmin.register StaticPage do
  permit_params :title, :content

  index do
    selectable_column
    id_column
    column :title
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :content, as: :text, input_html: { class: "text-editor" }
    end
    f.actions
  end
end
