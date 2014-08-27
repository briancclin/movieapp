Tmdb::Api.key("4ec3a19d6af74f88a492405690f72298")

File.open('movies.txt', 'r') do |line|  
  while movie = line.gets  
    paranthesis = movie[/\((.+)\)/]
    movie_year = paranthesis.tr('()','').strip
    movie_name = movie.gsub(paranthesis,'').strip
    result = Tmdb::Movie.find(movie_name)
    output = result[0]
    result.each do |item|
      if movie_name == item.original_title
        output = item;
        break
      end
    end
    movie_id = output.id;
    movie = Movie.new(name: movie_name, year: movie_year, themoviedb_id: movie_id)
    movie.save 
    #output = movie_name + ' ' + movie_year
    #puts output 
  end  
end  