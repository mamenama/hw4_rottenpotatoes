require 'spec_helper'

describe MoviesController do
  describe 'searching TMDb' do
    before :each do
      @fake_results=[mock('movie1'),mock('movie2')]
    end

    it 'should call the model method that performs TMDb search' do
      Movie.should_receive(:find_in_tmdb).with('hardware').and_return(@fake_results)
      post :search_tmdb, {:search_terms => 'hardware'}
    end

    describe 'after search' do
      before :each do 
	Movie.stub(:find_in_tmdb).and_return(@fake_results)
	post :search_tmdb, {:search_terms => 'hardware'}
      end

      it 'should select the Search Results template for rendering' do
	 response.should render_template('search_tmdb')
      end

      it 'should make the TMDb search results available to that  template' do
        assigns(:movies).should == @fake_results
      end
    end
  end
  
  describe 'search by director' do
    it 'should go to a RESTful route for finding similar movies' do
      post :find_with_same_director, {:movie_id=>1}
      assert_routing({:path=>'/movies/1/find_with_same_director'}, {:controller=>'movies',:action=>'find_with_same_director', :movie_id=>'1'})
    end
    it 'should grab the ID of the current movie' do
      Movie.should_receive(:with_same_director_as).with('1')
      post :find_with_same_director, {:movie_id => 1}
    end
    it 'should render the similar movies view' do
      post :find_with_same_director, {:movie_id=>1}
      response.should render_template('similar_movies')
    end
    it 'should send me to the homepage if no director is listed' do
      #movie=movies(:alien_movie)
      post :find_with_same_director, {:movie_id=>4}
      response.should redirect_to('/movies')
    end

  end
end
