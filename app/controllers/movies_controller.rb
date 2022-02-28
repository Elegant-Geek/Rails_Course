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

        movie_params = params.require(:movie).permit(:title, :description, :rating, :released_on, :total_gross)

        @movie.update(movie_params)

        redirect_to(movie_path(@movie))
    end

end
