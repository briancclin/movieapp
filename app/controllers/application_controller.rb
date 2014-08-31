class ApplicationController < ActionController::Base
  require 'themoviedb'
  require 'rottentomatoes'
  include RottenTomatoes
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :set_config
  Tmdb::Api.key("4ec3a19d6af74f88a492405690f72298")
  Rotten.api_key = "twvtkhmbbdkys45fk9tudk5t"
  def set_config
    @configuration = Tmdb::Configuration.new
  end
end
