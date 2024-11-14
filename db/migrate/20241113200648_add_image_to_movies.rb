class AddImageToMovies < ActiveRecord::Migration[7.2]
  def change
    add_column :movies, :image, :string
  end
end
