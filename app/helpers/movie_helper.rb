include RottenTomatoes

module MovieHelper
  
  # Embed the youtube link 
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

  # Get the corresponding image based on the rottentomatoes rating
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
  
  # Display the correct rottentomatoes text based on the rating
  def get_rotten_text(rating)
    if rating < 0
      return ""
    else
      return rating.to_s.strip + "%"
    end
  end

  # Get the correct rottentomatoes link
  def get_rotten_link(id)
    movie = RottenMovie.find(:id => id)
    return movie.links.alternate
  end
  
end
