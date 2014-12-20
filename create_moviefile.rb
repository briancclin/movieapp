#create movies.txt

movie_list = Dir.entries("D:/Movies")

#Remove home and previous directory

movie_list.delete_if{|movie| movie == "." or movie == ".."}

file = File.new("movies.txt", 'w')

movie_list.each do |movie|
  file.puts(movie)
end

file.close