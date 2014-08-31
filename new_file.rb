include RottenTomatoes
Rotten.api_key = "twvtkhmbbdkys45fk9tudk5t"
Tmdb::Api.key("4ec3a19d6af74f88a492405690f72298")


movie_name = "Furry Vengeance"
movie_year = 2010
    result = Tmdb::Movie.find(movie_name)
    output = result[0]
    result.each do |item|
      if movie_name == item.title
        if movie_year == item.release_date.split('-')[0]
          output = item
          break
        end
      end
    end
    movie_id = output.id
    moviedb = Tmdb::Movie.detail(output.id)
    imdb_id = (moviedb.imdb_id).gsub(/[^\d]/, '')
    imdb_rating = Imdb::Movie.new(imdb_id).rating
    puts imdb_id 
    movie_rotten = RottenMovie.find(:imdb => imdb_id)
    puts "IMDB"
    puts movie_rotten
     puts moviedb.title
    if movie_rotten.ratings.nil? or movie_rotten.title != output.title
      movie_rotten = RottenMovie.find(:title => moviedb.title, :limit => 1)
    end
    puts movie_rotten
    if(movie_rotten.empty?)
      rotten_rating = -1;
    else
      rotten_rating = movie_rotten.ratings.critics_score
    end