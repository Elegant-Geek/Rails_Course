class MoviesController < ApplicationController

    def index #action name goes here, index in this case. (which is tied to the name.html.erb view template file)
        # @movies = ["Iron Man", "Superman", "Spider-Man", "Avengers"]
        @movies = Movie.all
    end

    def show
        @movie = Movie.find(params[:id])
    end

    def edit
        @movie = Movie.find(params[:id])
    end

    def update
        @movie = Movie.find(params[:id])
        @movie.update(movie_params)
        redirect_to(movie_path(@movie))
    end

    def new
        @movie = Movie.new
    end

    def create
        @movie = Movie.new(movie_params)
        @movie.save
        redirect_to(movie_path(@movie))
    end

end

private
    def movie_params
        params.require(:movie).permit(:title, :description, :rating, :released_on, :total_gross)
    end
