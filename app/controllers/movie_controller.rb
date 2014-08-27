class MovieController < ApplicationController
 autocomplete :movie, :name, :full => true, :extra_data => [:year], :display_value => :movie_search_result
  def index
    @movie = Movie.all
  end
  def show
    @movie = Tmdb::Movie.detail(params[:id])
    imdb_id = @movie.imdb_id
    imdb_id = imdb_id.gsub(/[^\d]/, '')
    @imdb_rating = Imdb::Movie.new(imdb_id).rating
    @images = Tmdb::Movie.images(params[:id])
    @cast = Tmdb::Movie.casts(params[:id])
    @trailers = Tmdb::Movie.trailers(params[:id])
    @similar_movies = Tmdb::Movie.similar_movies(params[:id])
  end
end
