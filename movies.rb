movie_list = Dir.entries("D:/Movies")

#Remove home and previous directory

movie_list.delete_if{|movie| movie == "." or movie == ".."}

#puts movie_list

movie_list.each do |movie|
  
  paranthesis = movie[/\((.+)\)/]
  movie_year = paranthesis.tr('()','').strip
  movie_name = movie.gsub(paranthesis,'').strip
  movie = Movie.new(name: movie_name, year: movie_year)
  movie.save
  #output = movie_name + ' ' + movie_year
  #puts output
end
