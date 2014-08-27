class SearchController < ApplicationController
  def result
    movie = params[:query_str]
    paranthesis = movie[/\((.+)\)/]
    movie_name = movie.gsub(paranthesis,'').strip
    movie = Movie.where(name: movie_name).take
    redirect_to :controller => 'movie', :action => 'show', :id => movie.themoviedb_id
  end
end
