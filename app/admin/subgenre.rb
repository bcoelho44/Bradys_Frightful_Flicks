ActiveAdmin.register Subgenre do
  permit_params :name

  # Filters
  filter :name
  filter :created_at
  filter :updated_at

  # Index Page
  index do
    selectable_column
    column :name
    column :created_at
    column :updated_at
    column 'Movies' do |subgenre|
      subgenre.movies.map(&:title).join(', ') # Adjusted to reference `subgenre`
    end
    actions
  end

  # Form for creating/editing a subgenre
  form do |f|
    f.inputs 'Subgenre Details' do
      f.input :name
    end
    f.actions
  end
end