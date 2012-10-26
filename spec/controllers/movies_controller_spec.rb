require 'spec_helper'

describe MoviesController do
  describe 'finding movies by director' do
    before(:each) do
      @mov1 = Movie.create!(:id=>'1', :title=>'Movie1', :release_date=>'21 Nov 2010', :rating=>'G', :director=>'Dir1')
      @mov2 = Movie.create!(:id=>'2', :title=>'Movie2', :release_date=>'21 Nov 2010', :rating=>'G', :director=>'Dir1')
      @mov3 = Movie.create!(:id=>'3', :title=>'Movie3', :release_date=>'21 Nov 2010', :rating=>'G', :director=>'Dir2')
      @fake_results = [mock('movie1'), mock('movie2')]
    end
    after(:each) do
      @mov1.destroy
      @mov2.destroy
      @mov3.destroy
    end
    it 'should call model method for finding similar movies by director' do
      Movie.should_receive(:find_similar).with("2").and_return(@fake_results)
      get :similar, {:id => "2"}
    end  
    it 'should render the Similar Movies template' do
      Movie.stub(:find_similar).and_return(@fake_results)
      get :similar, {:id => "2"}
      response.should render_template('similar')
    end
    it 'should make the search results available to that template' do
      Movie.stub(:find_similar).and_return(@fake_results)
      get :similar, {:id => "2"}
      assigns(:movies).should == @fake_results
    end
    it 'should redirect to home page if director is unknown' do
      fake_movie = mock('Movie')
      fake_movie.stub(:director).and_return("")
      fake_movie.stub(:title).and_return("Blah")
      Movie.stub(:find_by_id).and_return(fake_movie)
      get :similar, {:id => "2"}
      response.should redirect_to root_path
    end      
  end
end
