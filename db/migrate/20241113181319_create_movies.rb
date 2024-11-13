class CreateMovies < ActiveRecord::Migration[7.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.integer :stock_quantity
      t.integer :release_year
      t.string :director
      t.integer :runtime
      t.string :image_url

      t.timestamps
    end
  end
end
