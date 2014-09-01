include RottenTomatoes
Rotten.api_key = "twvtkhmbbdkys45fk9tudk5t"
Tmdb::Api.key("4ec3a19d6af74f88a492405690f72298")

movie = Movie.all
movie.each do |item|
  rotten = RottenMovie.find(:id => item.rotten_id)
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
end