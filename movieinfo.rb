require 'rottentomatoes'
include RottenTomatoes
Rotten.api_key = "pwp4r2874qd8dzkhhebk7zcy"
Tmdb::Api.key("4ec3a19d6af74f88a492405690f72298")

class MovieInfo
  def get_movie_name_year
    new_movie_arr = Array.new
    File.open('movies.txt', 'r') do |line|  
    while movie = line.gets 
      paranthesis = movie[/\((.+)\)/]
      movie_year = paranthesis.tr('()','').strip
      movie_name = movie.gsub(paranthesis,'').strip
      movie_check = Movie.where(name: movie_name, year: movie_year).take
        if movie_check.nil?
          #puts movie_name
          new_movie_arr.push(movie_name + "|" + movie_year)
        end
    end
      return new_movie_arr
    end
   end
   
   def get_moviedb(movie_name, movie_year)
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
      return output.id
   end
   
   def get_rotten_info(imdb_id, movie_name)
     movie_rotten = RottenMovie.find(:imdb => imdb_id)
     if movie_rotten.empty?
       rotten_id = -1;
       rotten_rating = -1;
     else
       rotten_id = movie_rotten.id 
       if movie_rotten.ratings.nil? or movie_rotten.ratings.empty?
         rotten_rating = -1;
       else
         rotten_rating = movie_rotten.ratings.critics_score
       end
     end
     
     if rotten_rating == -1
       movie_rotten = RottenMovie.find(:title => movie_name, :limit => 1)
       if !movie_rotten.empty?
         rotten_id = movie_rotten.id
         rotten_rating = movie_rotten.ratings.critics_score
       end
     end
     
     if rotten_id.nil?
       rotten_id = -1
     end
     
     return rotten_id.to_s + "|" + rotten_rating.to_s
   end
   
   def get_other_rotten(rotten_id)
     rotten = RottenMovie.find(:id => rotten_id, :limit => 1)
     if rotten.empty?
       rotten_link = ""
       fresh = false
     else
       rotten_link = rotten.links.alternate
       if rotten.ratings.critics_rating == "Certified Fresh"
         fresh = true
       else
         fresh = false
       end
     end
     
     return rotten_link + "|" + fresh.to_s
   end
end