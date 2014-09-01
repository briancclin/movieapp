require 'rottentomatoes'
include RottenTomatoes
Rotten.api_key = "twvtkhmbbdkys45fk9tudk5t"

movie = Movie.all
movie.each do |item|
  puts item.rotten_id
  rotten = RottenMovie.find(:id => item.rotten_id, :limit => 1)
  if rotten.empty?
    item.update(:rotten_link => "")
  else
    item.update(:rotten_link => rotten.links.alternate)
  end
  if rotten.empty?
    fresh = false
  else
    if rotten.ratings.critics_rating == "Certified Fresh"
      fresh = true
    else
      fresh = false
    end
  end
  item.update(:certified_fresh => fresh)
  sleep(3)
end