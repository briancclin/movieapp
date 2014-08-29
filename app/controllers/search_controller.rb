class SearchController < ApplicationController
  def result 
      movie = params[:query_str]
      if(movie != "")
        paranthesis = movie[/\((.+)\)/] 
        if(paranthesis != nil)
          movie_name = movie.gsub(paranthesis,'').strip
          movie = Movie.where(name: movie_name).take
          redirect_to :controller => 'movie', :action => 'show', :id => movie.themoviedb_id
        else
          redirect_to :controller => 'search', :action => 'error'
        end
      else
        redirect_to :controller => 'search', :action => 'error'
      end
  end
  def error
  end
end
