class RenameGenresToSubgenres < ActiveRecord::Migration[7.0]
  def change
    rename_table :genres, :subgenres
    rename_table :movie_genres, :movie_subgenres
    rename_column :movie_subgenres, :genre_id, :subgenre_id
  end
end
