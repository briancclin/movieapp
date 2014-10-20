require_relative 'movieinfo'
require 'rottentomatoes'
include RottenTomatoes
Rotten.api_key = "pwp4r2874qd8dzkhhebk7zcy"
Tmdb::Api.key("4ec3a19d6af74f88a492405690f72298")

db = MovieInfo.new
movie_arr = db.get_movie_name_year
movie_arr.each do |movie|
  movie_name = movie.split('|')[0]
  movie_year = movie.split('|')[1]
  movie_id = db.get_moviedb(movie_name, movie_year)
  moviedb = Tmdb::Movie.detail(movie_id)
  imdb_id = (moviedb.imdb_id).gsub(/[^\d]/, '')
  imdb_rating = Imdb::Movie.new(imdb_id).rating
  poster_path = moviedb.poster_path
  rotten_info = db.get_rotten_info(imdb_id, movie_name)
  rotten_id = (rotten_info.split('|')[0]).to_i
  rotten_rating = (rotten_info.split('|')[1]).to_i
  other_rotten = db.get_other_rotten(rotten_id)
  rotten_link = other_rotten.split('|')[0]
  if other_rotten.split('|')[1] == "true"
    fresh = true
  else
    fresh = false
  end
  add_movie = Movie.new(name: movie_name, year: movie_year, imdb_id: imdb_id, themoviedb_id: movie_id, poster_path: poster_path, imdb_rating: imdb_rating, rotten_id: rotten_id, rotten_rating: rotten_rating, rotten_link: rotten_link, certified_fresh: fresh)
  add_movie.save
end
