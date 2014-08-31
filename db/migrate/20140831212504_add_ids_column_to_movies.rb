class AddIdsColumnToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :imdb_id, :integer
    add_column :movies, :rotten_id, :integer
  end
end
