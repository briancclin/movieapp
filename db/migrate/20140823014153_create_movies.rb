class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.integer :year
      t.integer :themoviedb_id
      t.string :poster_path
      t.timestamps
    end
  end
end
