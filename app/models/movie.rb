class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def name_with_rating
    return self.title + " (" + self.rating + ")"
  end

  def self.with_same_director_as(movie_id)
    return Movie.find_all_by_director(self.find_by_id(movie_id).director)
  end
end
