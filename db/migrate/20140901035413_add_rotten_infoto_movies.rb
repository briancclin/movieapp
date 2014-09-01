class AddRottenInfotoMovies < ActiveRecord::Migration
  def change
    add_column :movies, :rotten_link, :string
    add_column :movies, :certified_fresh, :boolean
  end
end
