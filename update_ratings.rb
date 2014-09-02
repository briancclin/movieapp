require 'rottentomatoes'
include RottenTomatoes
Rotten.api_key = "pwp4r2874qd8dzkhhebk7zcy"
Tmdb::Api.key("4ec3a19d6af74f88a492405690f72298")

movie = Movie.find_by_sql("SELECT * FROM movies WHERE rotten_rating = '-1'")
movie.each do |item|
   movie_rotten = RottenMovie.find(:title => item.name, :limit => 1)
   if !movie_rotten.empty?
     rotten_id = movie_rotten.id
     rotten_rating = movie_rotten.ratings.critics_score
     item.update(rotten_id: rotten_id)
  item.update(rotten_rating: rotten_rating)
   end
end

movie = Movie.find_by_sql("SELECT * FROM movies WHERE rotten_id IS NULL")
movie.each do |item|
  rotten_id = -1;
  item.update(rotten_id: rotten_id)
end
