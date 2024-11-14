ActiveAdmin.register Movie do
  permit_params :title, :description, :price, :stock_quantity, :release_year, :director, :runtime, :image, subgenre_ids: []

  # Customize filters
  filter :title
  filter :description
  filter :price
  filter :stock_quantity
  filter :release_year
  filter :director
  filter :runtime
  filter :subgenres, as: :select, collection: Subgenre.all.map(&:name)


  index do
    selectable_column
    column :title
    column :description
    column :price
    column :stock_quantity
    column :release_year
    column :director
    column :runtime
    column 'Subgenres' do |movie|
      movie.subgenres.map(&:name).join(', ')
    end
    column 'Image' do |movie|
      if movie.image.attached?
        image_tag url_for(movie.image), size: "50x50"
      else
        "No Image"
      end
    end
    actions
  end

  form do |f|
    f.inputs 'Movie Details' do
      f.input :title
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :release_year
      f.input :director
      f.input :runtime
      f.input :image, as: :file
    end

    f.inputs 'Subgenres' do
      f.input :subgenres, as: :check_boxes, collection: Subgenre.all
    end

    f.actions
  end
end
