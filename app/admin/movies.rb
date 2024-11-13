ActiveAdmin.register Movie do
  # Permitted parameters for strong parameters
  permit_params :title, :description, :price, :stock_quantity, :release_year, :director, :runtime, :image

  # Form configuration for creating/editing a movie
  form do |f|
    f.inputs 'Movie Details' do
      f.input :title
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :release_year
      f.input :director
      f.input :runtime
      f.input :image, as: :file # Allows uploading an image
    end
    f.actions
  end
end
