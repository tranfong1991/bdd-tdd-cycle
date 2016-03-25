require 'spec_helper'

describe MoviesController do
    describe "pages" do
        it "should go to similar movies page" do
            {:get => similar_movies_path(1)}.should route_to(
                :controller => "movies",
                :action => "similar_movies",
                :id => "1"
            )
        end
        
        it "should go to edit page" do
            {:get => edit_movie_path(1)}.should route_to(
                :controller => "movies",
                :action => "edit",
                :id => "1"
            )
        end
        
        it "should go to index page" do
            {:get => movies_path}.should route_to(
                :controller => "movies",
                :action => "index"
            )
        end
        
        it "should go to new page" do
            {:get => new_movie_path}.should route_to(
                :controller => "movies",
                :action => "new",
            )
        end
        
        it "should go to show page" do
            {:get => movie_path(1)}.should route_to(
                :controller => "movies",
                :action => "show",
                :id => "1"
            )
        end
    end

    describe "methods" do
        it "should create new movie" do
            Movie.stub(:create).and_return(double(Movie))
            post :create
            flash[:notice].should =~ /successfully created/i
        end
        
        before(:each) do
            @movie = Movie.create :title => "Alien", :director => nil, :release_date => "1979-05-25"
        end
        
        it "should show movie details" do
            get :show, :id => @movie
            assigns(:movie).should == @movie
        end
        
        it "should edit movie" do
            get :edit, :id => @movie
            assigns(:movie).should == @movie
        end
        
        it "should update movie" do
            put :update, :id => @movie, :rating => 'PG'
            flash[:notice].should =~ /successfully updated/i
        end
        
        it "should destroy movie" do
            delete :destroy, :id => @movie
            flash[:notice].should =~ /deleted/i
        end
        
        it "should display ''Alien' has no director info'" do
            get :similar_movies, :id => @movie
            flash[:notice].should =~ /no director info/i
        end
        
        it "should sort by title" do
            get :index, :sort => 'title'
            session[:sort].should == 'title'
        end
        
        it "should sort by release date" do
            get :index, :sort => 'release_date'
            session[:sort].should == 'release_date'
        end
        
        it "should show movie by certain ratings" do
            get :index, :ratings => ['G', 'PG', 'R']
            session[:ratings].should == ['G', 'PG', 'R']
        end
    end
end