require 'date'
Tmdb::Api.key("4ec3a19d6af74f88a492405690f72298")

#script to update release_dates

movie = Movie.all
movie.each do |item|
  #get imdb release dates
  movie_details = Imdb::Movie.new(item.imdb_id)
  output = movie_details.release_date
  
  #check if output is nil
  if output.nil?
    movie_details = Tmdb::Movie.detail(item.themoviedb_id)
    item.update(release_date: movie_details.release_date)
  else
    split_date = output.split(' ')
    #check if the output was split correctly by spaces
    if split_date[0].to_i == 0 || split_date[2].to_i == 0 || split_date[2].to_i != item.year
      #get themoviedb release dates
      movie_details = Tmdb::Movie.detail(item.themoviedb_id)
      item.update(release_date: movie_details.release_date)
    else
      #format is separated by a space ' '
      day = split_date[0].to_i
      month = Date::MONTHNAMES.index(split_date[1])
      year = split_date[2].to_i
      release_date = Date.new(year,month,day).to_s
      item.update(release_date: release_date)
    end
  end
end
