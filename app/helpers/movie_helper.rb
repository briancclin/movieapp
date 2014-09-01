include RottenTomatoes

module MovieHelper
  def get_rotten_image(rating, fresh)
    if fresh == true
      return "certified.gif"
    end
    if rating >= 60 
      return "fresh.png"
    elsif rating < 0
      return ""
    else
      return "rotten.png"
    end
  end
  
  def get_rotten_text(rating)
    if rating < 0
      return ""
    else
      return rating.to_s + "%"
    end
  end
end

  def get_rotten_link(id)
    movie = RottenMovie.find(:id => id)
    return movie.links.alternate
  end

