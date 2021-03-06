include RottenTomatoes
Rotten.api_key = "pwp4r2874qd8dzkhhebk7zcy"
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
      poster_path = output.poster_path
      movie = Movie.new(name: movie_name, year: movie_year, themoviedb_id: movie_id, poster_path: poster_path, imdb_rating: imdb_rating)
      movie.save 
    #output = movie_name + ' ' + movie_year
    #puts output 
  end  
end  