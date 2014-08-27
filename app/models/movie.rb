class Movie < ActiveRecord::Base
  def movie_search_result
    "#{self.name} (#{self.year})"
  end
end
