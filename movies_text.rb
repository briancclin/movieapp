include RottenTomatoes
Rotten.api_key = "twvtkhmbbdkys45fk9tudk5t"
Tmdb::Api.key("4ec3a19d6af74f88a492405690f72298")

File.open('movies.txt', 'r') do |line|  
  while movie = line.gets  
    paranthesis = movie[/\((.+)\)/]
    movie_year = paranthesis.tr('()','').strip
    movie_name = movie.gsub(paranthesis,'').strip
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
      movie_rotten = RottenMovie.find(:imdb => imdb_id)
      if movie_rotten.ratings.nil? or movie_rotten.empty?  
    movie_rotten = RottenMovie.find(:title => moviedb.title, :limit => 1)
  elsif movie_rotten.ratings.empty? or movie_rotten.empty? or movie_rotten.ratings.critics_score == -1
    movie_rotten = RottenMovie.find(:title => moviedb.title, :limit => 1)
  end
      if(movie_rotten.empty?)
        rotten_rating = -1;
      else
        if(movie_rotten.ratings.empty?)
          rotten_rating = -1;
        else
          rotten_rating = movie_rotten.ratings.critics_score
        end
      end
      poster_path = output.poster_path
      movie = Movie.new(name: movie_name, year: movie_year, themoviedb_id: movie_id, poster_path: poster_path, imdb_rating: imdb_rating, rotten_rating: rotten_rating)
      movie.save 
    #output = movie_name + ' ' + movie_year
    #puts output 
  end  
end  