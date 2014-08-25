class ApplicationController < ActionController::Base
  require 'themoviedb'
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_config
  Tmdb::Api.key("4ec3a19d6af74f88a492405690f72298")
  
  def set_config
    @configuration = Tmdb::Configuration.new
  end
end
