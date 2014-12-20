require 'rottentomatoes'
include RottenTomatoes
Rotten.api_key = "pwp4r2874qd8dzkhhebk7zcy"

movie = Movie.all
movie.each do |item|
  rotten = RottenMovie.find(:id => item.rotten_id, :limit => 1)
  if rotten.empty?
    item.update(:rotten_link => "")
    fresh = false
  else
    item.update(:rotten_link => rotten.links.alternate)
    if rotten.ratings.critics_rating == "Certified Fresh"
      fresh = true
    else
      fresh = false
    end
  end
  item.update(:certified_fresh => fresh)
  sleep(1)
end