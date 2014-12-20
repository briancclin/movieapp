require 'rottentomatoes'
include RottenTomatoes
Rotten.api_key = "pwp4r2874qd8dzkhhebk7zcy"
Tmdb::Api.key("4ec3a19d6af74f88a492405690f72298")

movie = Movie.find_by_sql("SELECT * FROM movies WHERE poster_path IS NULL")
movie.each do |item|
   moviedb = Tmdb::Movie.detail(item.themoviedb_id)
   item.update(poster_path: moviedb.poster_path)
   imdb_id = (moviedb.imdb_id).gsub(/[^\d]/, '')
   item.update(imdb_id: imdb_id)
end

movie = Movie.find_by_sql("SELECT * FROM movies WHERE imdb_id IS NULL")
movie.each do |item|
   moviedb = Tmdb::Movie.detail(item.themoviedb_id)
   imdb_id = (moviedb.imdb_id).gsub(/[^\d]/, '')
   item.update(imdb_id: imdb_id)
end