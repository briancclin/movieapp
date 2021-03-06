require 'jquery-lazy-images'

class MovieController < ApplicationController
 autocomplete :movie, :name, :full => true, :extra_data => [:year], :display_value => :movie_search_result
  def index
    @movie = Movie.all.order(name: :asc)
    @length = Movie.count
  end
  def show
    @movie = Movie.find(params[:id])
    @moviedb = Tmdb::Movie.detail(@movie.themoviedb_id)
    @imdb_rating = @movie.imdb_rating
    @trailers = Tmdb::Movie.trailers(@movie.themoviedb_id)
    @cast = Tmdb::Movie.casts(@movie.themoviedb_id)
    @cast_init = @cast.first(5)
    @cast.shift(5)
    @cast_rest = @cast
    @crew = Tmdb::Movie.credits(@movie.themoviedb_id)['crew']
    @crew.each do |person|
      if person['job'] == "Director"
        @director = person['name']
      end
    end
    #@similar_movies = Tmdb::Movie.similar_movies(params[:id])
    @rotten_rating = @movie.rotten_rating
    @backdrop = @moviedb.backdrop_path
  end
   def result 
      movie = params[:query_str]
      paranthesis = movie[/\((.+)\)/] 
      movie_year = paranthesis.tr('()','').strip
      movie_name = movie.gsub(paranthesis,'').strip
      movie = Movie.where(name: movie_name, year: movie_year).take
      redirect_to :controller => 'movie', :action => 'show', :id => movie.id
  end
end