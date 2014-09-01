require 'jquery-lazy-images'

class MovieController < ApplicationController
 autocomplete :movie, :name, :full => true, :extra_data => [:year], :display_value => :movie_search_result
  def index
    @movie = Movie.all.sort()
  end
  def show
    @movie = Tmdb::Movie.detail(params[:id])
    imdb_id = @movie.imdb_id
    imdb_id = imdb_id.gsub(/[^\d]/, '')
    @imdb_rating = Imdb::Movie.new(imdb_id).rating
    @images = Tmdb::Movie.images(params[:id])
    @cast = Tmdb::Movie.casts(params[:id])
    @trailers = Tmdb::Movie.trailers(params[:id])
    #@similar_movies = Tmdb::Movie.similar_movies(params[:id])
      @movie_rotten = RottenMovie.find(:imdb => imdb_id)
    if @movie_rotten.ratings.nil?
      @movie_rotten = RottenMovie.find(:title => @movie.title, :limit => 1)
    end
    @rotten_rating = @movie_rotten.ratings.critics_score
  end
end
