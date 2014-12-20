class SearchController < ApplicationController
  def result 
      movie = params[:query_str]
      if(movie != "")
        paranthesis = movie[/\((.+)\)/] 
        if(paranthesis != nil)
          movie_year = paranthesis.tr('()','').strip
          movie_name = movie.gsub(paranthesis,'').strip
          movie = Movie.where(name: movie_name, year: movie_year).take
          redirect_to :controller => 'movie', :action => 'show', :id => movie.id
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
