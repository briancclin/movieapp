include RottenTomatoes
Rotten.api_key = "twvtkhmbbdkys45fk9tudk5t"
Tmdb::Api.key("4ec3a19d6af74f88a492405690f72298")

movie = Movie.all
movie.each do |item|
  movie_details = Tmdb::Movie.detail(item.themoviedb_id)
  imdb_id = movie_details.imdb_id.gsub(/[^\d]/, '')
  item.update(imdb_id: imdb_id)
  movie_rotten = RottenMovie.find(:imdb => imdb_id)
  if movie_rotten.ratings.empty? or movie_rotten.empty? or movie_rotten.ratings.critics_score == -1
    movie_rotten = RottenMovie.find(:title => movie_details.title, :limit => 1)
  end
  if(movie_rotten.empty?)
    rotten_id = -1;
    rotten_rating = -1;
  else
    rotten_id = movie_rotten.id 
    if(movie_rotten.ratings.empty?)
      rotten_rating = -1;
    else
      rotten_rating = movie_rotten.ratings.critics_score
    end
  end
  puts rotten_id
  item.update(rotten_id: rotten_id)
  item.update(rotten_rating: rotten_rating)
end