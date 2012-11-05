require 'spec_helper'

describe Movie do
  fixtures :movies
  it 'should include rating and year in name' do
    movie=movies(:milk_movie)
    movie.name_with_rating.should =='Milk (R)'
  end

  describe 'Find by director' do
     it 'should return movies by the same director' do
       movie1=movies(:milk_movie)
       movie_with_dirs=[movies(:milk_movie),movies(:food_inc_movie)]
       Movie.with_same_director_as(movie1).should == movie_with_dirs
     end     
  end
end
