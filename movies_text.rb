File.open('movies.txt', 'r') do |line|  
  while movie = line.gets  
    paranthesis = movie[/\((.+)\)/]
    movie_year = paranthesis.tr('()','').strip
    movie_name = movie.gsub(paranthesis,'').strip
    movie = Movie.new(name: movie_name, year: movie_year)
    movie.save 
    #output = movie_name + ' ' + movie_year
    #puts output 
  end  
end  