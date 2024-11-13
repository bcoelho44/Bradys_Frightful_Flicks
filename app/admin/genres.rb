ActiveAdmin.register Genre do
  permit_params :name

  form do |f|
    f.inputs 'Genre Details' do
      f.input :name
    end
    f.actions
  end
end
