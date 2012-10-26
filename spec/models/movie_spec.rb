require 'spec_helper'

describe Movie do
  describe 'find similar-director movies by movie id' do
    before(:each) do
      @mov1 = Movie.create!(:id=>'1', :title=>'Movie1', :release_date=>'21 Nov 2010', :rating=>'G', :director=>'Dir1')
      @mov2 = Movie.create!(:id=>'2', :title=>'Movie2', :release_date=>'21 Nov 2010', :rating=>'G', :director=>'Dir1')
      @mov3 = Movie.create!(:id=>'3', :title=>'Movie3', :release_date=>'21 Nov 2010', :rating=>'G', :director=>'Dir2')
    end
    after(:each) do
      @mov1.destroy
      @mov2.destroy
      @mov3.destroy
    end
    it 'should return a collection of similar movies given a movie id' do      
      Movie.find_similar('1').should == [@mov1, @mov2]
      Movie.find_similar('3').should == [@mov3]      
    end
  end
end
