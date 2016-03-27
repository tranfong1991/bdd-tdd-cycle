require 'spec_helper'

describe Movie do
    it "should return all ratings" do
        Movie.all_ratings.should eq(%w(G PG PG-13 NC-17 R))
    end
    
    it "should return list of movies with the same director" do
        Movie.create({:title => "Star Wars", :rating => 'PG', :director => "George Lucas", :release_date => "1977-05-25"})
        Movie.create({:title => "THX-1138", :rating => 'PG', :director => "George Lucas", :release_date => "1971-03-11"})
        
        movies = Movie.movies_by_director("George Lucas")
        movies[0].title.should eq('Star Wars')
        movies[1].title.should eq('THX-1138')
    end
end