include RottenTomatoes

module MovieHelper
  def youtube_embed(youtube_url)
  if youtube_url[/youtu\.be\/([^\?]*)/]
    youtube_id = $1
  else
    # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
    youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
    youtube_id = $5
  end
  return "http://www.youtube.com/embed/#{ youtube_id }" 
end

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
      return rating.to_s.strip + "%"
    end
  end
end

  def get_rotten_link(id)
    movie = RottenMovie.find(:id => id)
    return movie.links.alternate
  end
 

